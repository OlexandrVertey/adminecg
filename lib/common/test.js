const https = require("https");

/**
 * Send email using SendGrid API.
 * @param {Object} data - The data for the email.
 * @param {string} data.email - The recipient's email address.
 * @param {string} data.password - The password for the account.
 */
async function sendEmail(data) {
  const postData = JSON.stringify({
    personalizations: [
      {
        to: [
          { email: data.email },
        ],
        subject: "You have registered account in the ECG Practice Application",
      },
    ],
    from: {
      email: "ecgpracticeapp@gmail.com",
    },
    content: [
      {
        type: "text/plain",
        value: "You have a registered account",
      },
    ],
  });

  const options = {
    hostname: "api.sendgrid.com",
    path: "/v3/mail/send",
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "Authorization":
        "Bearer SG.QShi0DRjSNK9JDVraCBE0w." +
        "GdB76l5ONWh82QKJBWpbRR8jn7VfP-gD4nYFw5AsbrA",
    },
  };

  const req = https.request(options, (res) => {
    let responseBody = "";

    res.on("data", (chunk) => {
      responseBody += chunk;
    });

    res.on("end", () => {
      if (res.statusCode === 202) {
        console.log("Email sent successfully!");
      } else {
        console.log(`Failed to send email: ${responseBody}`);
      }
    });
  });

  req.on("error", (error) => {
    console.error(`Error with request: ${error.message}`);
  });

  req.write(postData);
  req.end();
}