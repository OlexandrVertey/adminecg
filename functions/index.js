const https = require("https");
const functions = require("firebase-functions");
const options = {
  hostname: "api.sendgrid.com",
  path: "/v3/mail/send",
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    "Authorization":
      "Bearer S" +
      "GA",
  },
};

exports.listFruit = functions.https.onCall((data, context) => {
  return ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"];
});

exports.writeMessage = functions.https.onCall(async (data, context) => {
  const original = data.text;
  return `Successfully received: ${original}`;
});

exports.sendgrid = functions.https.onRequest((req, res) => {
  const postData = JSON.stringify({
    personalizations: [
      {
        to: [
          {email: "gss.guru.info@gmail.com"},
        ],
        subject: "Welcome to the App",
      },
    ],
    from: {
      email: "ecgpracticeapp@gmail.com",
    },
    content: [
      {
        type: "text/plain",
        value: "Your password is pass",
      },
    ],
  });

  const request = https.request(options, (response) => {
    response.on("data", (chunk) => {
      res.send("PROGRESS!");
    });
    response.on("end", () => {
      if (response.statusCode === 202) {
        res.status(200).send("Email sent successfully!");
      } else {
        res.send("PROGRESS!");
      }
    });
  });
  request.on("error", (error) => {
    res.send("ERROR!");
  });

  request.write(postData);
  request.end();
});

exports.sendgridV1 = functions.https.onRequest((req, res) => {
  const {toEmail, subject, content} = req.body;

  const postData = JSON.stringify({
    personalizations: [
      {
        to: [{email: toEmail}],
        subject: subject || "Welcome to the App",
      },
    ],
    from: {
      email: "ecgpracticeapp@gmail.com",
    },
    content: [
      {
        type: "text/plain",
        value: content || "Welcome to the App Content",
      },
    ],
  });

  const request = https.request(options, (response) => {
    response.on("end", () => {
      if (response.statusCode === 202) {
        res.status(200).send("Email sent successfully!");
      } else {
        res.status(response.statusCode).send("Failed to send email");
      }
    });
  });

  request.on("error", (error) => {
    console.error(`Error with request: ${error.message}`);
    res.status(500).send(`Server error: ${error.message}`);
  });

  request.write(postData);
  request.end();
});

exports.sendEmail = functions.https.onCall((data, context) => {
  const {toEmail, subject, content} = data;

  const postData = JSON.stringify({
    personalizations: [
      {
        to: [{email: toEmail}],
        subject: subject || "Welcome to the App",
      },
    ],
    from: {
      email: "ecgpracticeapp@gmail.com",
    },
    content: [
      {
        type: "text/plain",
        value: content || "Welcome to the App Content",
      },
    ],
  });

  return new Promise((resolve, reject) => {
    const request = https.request(options, (response) => {
      response.on("end", () => {
        if (response.statusCode === 202) {
          resolve({message: "Email sent successfully"});
        } else {
          reject(new functions.https.HttpsError("unknown", "responseBody"));
        }
      });
    });

    request.on("error", (error) => {
      reject(new functions.https.HttpsError("unknown", "successfully"));
    });

    request.write(postData);
    request.end();
  });
});
