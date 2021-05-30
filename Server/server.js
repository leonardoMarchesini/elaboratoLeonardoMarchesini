const express = require("express");
const bodyParser = require("body-parser");
const nodemailer = require("nodemailer");
const {google} = require("googleapis");
const helmet = require("helmet");

const CLIENT_ID = "846237031844-shr5cln5jfeldcp43o61k5llogn2di85.apps.googleusercontent.com";
const CLIENT_SECRET = "_jxp1cx7RIdoB8CAHitVmVOD";
const REDIRECT_URI = "https://developers.google.com/oauthplayground";
const REFRESH_TOKEN = "1//04NG-tthDoVglCgYIARAAGAQSNwF-L9Ir2HtGVxWkRxumMcGYo26Hn-1jSf7Rn3-uifLyj5WI8VplzY8fpzdJxImMWRG0Fa4_fPA";

const oAuth2Client = new google.auth.OAuth2(CLIENT_ID, CLIENT_SECRET, REDIRECT_URI);
oAuth2Client.setCredentials({refresh_token: REFRESH_TOKEN});

async function sendMail() {
  try{
    const accessToken = await oAuth2Client.getAccessToken()

    const transport = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        type: 'OAuth2',
        user: 'leonardo.marchesini@itiszuccante.edu.it',
        clientId: CLIENT_ID,
        clientSecret: CLIENT_SECRET,
        refreshToken: REFRESH_TOKEN,
        accessToken: accessToken,
      }
    })

    const mailOptions = {
      from: "SmartSocial <leonardo.marchesini@itiszuccante.edu.it>",
      to: "$userEmail",
      subject: "There are new events you are interested in over the next week in your ZIP!",
      text: "Hey user, there will be some new interesting events in your zip code next week. Go now to see which ones from the website or application!",
      html: "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html xmlns='http://www.w3.org/1999/xhtml' xmlns:v='urn:schemas-microsoft-com:vml' xmlns:o='urn:schemas-microsoft-com:office:office'><head>	<meta http-equiv='Content-type' content='text/html; charset=utf-8' />	<meta name='viewport' content='width=device-width, initial-scale=1, maximum-scale=1' />    <meta http-equiv='X-UA-Compatible' content='IE=edge' />	<meta name='format-detection' content='date=no' />	<meta name='format-detection' content='address=no' />	<meta name='format-detection' content='telephone=no' />	<meta name='x-apple-disable-message-reformatting' />	<link href='https://fonts.googleapis.com/css?family=Noto+Sans:400,400i,700,700i' rel='stylesheet' />	<title>Email Template</title>		<style type='text/css' media='screen'>		body { padding:0 !important; margin:0 !important; display:block !important; min-width:100% !important; width:100% !important; background:#f4f4f4; -webkit-text-size-adjust:none }		a { color:#6134A9; text-decoration:none }		p { padding:0 !important; margin:0 !important } 		img { -ms-interpolation-mode: bicubic; }		.mcnPreviewText { display: none !important; }						@media only screen and (max-device-width: 480px), only screen and (max-width: 480px) {			.mobile-shell { width: 100% !important; min-width: 100% !important; }			.bg { background-size: 100% auto !important; -webkit-background-size: 100% auto !important; }						.text-header,			.m-center { text-align: center !important; }						.center { margin: 0 auto !important; }			.container { padding: 20px 10px !important }						.td { width: 100% !important; min-width: 100% !important; }			.m-br-15 { height: 15px !important; }			.p30-15 { padding: 30px 15px !important; }			.p40 { padding: 20px !important; }			.m-td,			.m-hide { display: none !important; width: 0 !important; height: 0 !important; font-size: 0 !important; line-height: 0 !important; min-height: 0 !important; }			.m-block { display: block !important; }			.fluid-img img { width: 100% !important; max-width: 100% !important; height: auto !important; }			.column,			.column-top,			.column-empty,			.column-empty2,			.column-dir-top { float: left !important; width: 100% !important; display: block !important; }			.column-empty { padding-bottom: 10px !important; }			.column-empty2 { padding-bottom: 20px !important; }			.content-spacing { width: 15px !important; }		}	</style></head><body class='body' style='padding:0 !important; margin:0 !important; display:block !important; min-width:100% !important; width:100% !important; background:#f4f4f4; -webkit-text-size-adjust:none;'>	<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f4f4f4'>		<tr>			<td align='center' valign='top'>				<table width='650' border='0' cellspacing='0' cellpadding='0' class='mobile-shell'>					<tr>						<td class='td container' style='width:650px; min-width:650px; font-size:0pt; line-height:0pt; margin:0; font-weight:normal; padding:55px 0px;'>							<table width='100%' border='0' cellspacing='0' cellpadding='0'>								<tr>									<td style='padding-bottom: 20px;'>										<table width='100%' border='0' cellspacing='0' cellpadding='0'>											<tr>												<td class='p30-15' style='padding: 25px 30px 25px 30px;' bgcolor='#ffffff'>													<table width='100%' border='0' cellspacing='0' cellpadding='0'>														<tr>															<th class='column-top' width='145' style='font-size:0pt; line-height:0pt; padding:0; margin:0; font-weight:normal; vertical-align:top;'>																<table width='100%' border='0' cellspacing='0' cellpadding='0'>																	<tr>																		<td class='img m-center' style='font-size:0pt; line-height:0pt; text-align:left;'><img src='https://firebasestorage.googleapis.com/v0/b/smartsocial-bad2d.appspot.com/o/Schermata%202021-05-25%20alle%2013.25.56.png?alt=media&token=36e9ca55-dd5a-4da6-9f62-2fe1d367fdd0' width='167' height='31' border='0' alt='' /></td>																	</tr>																</table>															</th>															<th class='column-empty' width='1' style='font-size:0pt; line-height:0pt; padding:0; margin:0; font-weight:normal; vertical-align:top;'></th>															<th class='column' style='font-size:0pt; line-height:0pt; padding:0; margin:0; font-weight:normal;'>																<table width='100%' border='0' cellspacing='0' cellpadding='0'>																	<tr>																		<td class='text-header' style='color:#999999; font-family:Noto Sans, Arial,sans-serif; font-size:12px; line-height:16px; text-align:right; text-transform:uppercase;'><a href='#' target='_blank' class='link2' style='color:#999999; text-decoration:none;'><span class='link2' style='color:#999999; text-decoration:none;'>Open in your browser</span></a></td>																	</tr>																</table>															</th>														</tr>													</table>												</td>											</tr>										</table>									</td>								</tr>							</table>							<table width='100%' border='0' cellspacing='0' cellpadding='0'>								<tr>									<td style='padding-bottom: 20px;'>										<table width='100%' border='0' cellspacing='0' cellpadding='0'>											<tr>												<td background='images/t8_bg.jpg' bgcolor='#114490' valign='top' height='366' class='bg' style='background-size:cover !important; -webkit-background-size:cover !important; background-repeat:none;'>													<div>														<table width='100%' border='0' cellspacing='0' cellpadding='0'>															<tr>																<td class='content-spacing' width='30' height='366' style='font-size:0pt; line-height:0pt; text-align:left;'></td>																<td style='padding: 30px 0px;'>																	<table width='100%' border='0' cellspacing='0' cellpadding='0'>																		<tr>																			<td class='h1 center pb25' style='color:#ffffff; font-family:Noto Sans, Arial,sans-serif; font-size:40px; line-height:46px; text-align:center; padding-bottom:25px;'>Hey user</td>																		</tr>																		<tr>																			<td class='text-center' style='color:#ffffff; font-family:Noto Sans, Arial,sans-serif; font-size:16px; line-height:30px; text-align:center;'>There will be some new interesting events in your zip code next week. Go now to see which ones from the website or application!</td>																		</tr>																	</table>																</td>																<td class='content-spacing' width='30' style='font-size:0pt; line-height:0pt; text-align:left;'></td>															</tr>														</table>													</div>												</td>											</tr>											<tr>												<td class='mp15' style='padding: 20px 30px;' bgcolor='#6134A9' align='center'>													<table border='0' cellspacing='0' cellpadding='0'>														<tr>															<th class='column' style='font-size:0pt; line-height:0pt; padding:0; margin:0; font-weight:normal;'>																<table width='100%' border='0' cellspacing='0' cellpadding='0'>																	<tr>																		<td class='h5 white' style='font-family:Noto Sans, Arial,sans-serif; font-size:16px; line-height:22px; text-align:left; font-weight:bold; color:#ffffff;'>SPORT EVENT</td>																	</tr>																</table>															</th>															<th class='column' width='50' style='font-size:0pt; line-height:0pt; padding:0; margin:0; font-weight:normal;'></th>															<th class='column' style='font-size:0pt; line-height:0pt; padding:0; margin:0; font-weight:normal;'>																<table width='100%' border='0' cellspacing='0' cellpadding='0'>																	<tr>																		<td class='h5 white' style='font-family:Noto Sans, Arial,sans-serif; font-size:16px; line-height:22px; text-align:left; font-weight:bold; color:#ffffff;'>DANCING EVENT</td>																	</tr>																</table>															</th>															<th class='column' width='50' style='font-size:0pt; line-height:0pt; padding:0; margin:0; font-weight:normal;'></th>															<th class='column' style='font-size:0pt; line-height:0pt; padding:0; margin:0; font-weight:normal;'>																<table width='100%' border='0' cellspacing='0' cellpadding='0'>																	<tr>																		<td class='h5 white' style='font-family:Noto Sans, Arial,sans-serif; font-size:16px; line-height:22px; text-align:left; font-weight:bold; color:#ffffff;'>AND MUCH OTHER</td>																	</tr>																</table>															</th>														</tr>													</table>												</td>											</tr>										</table>									</td>								</tr>							</table>							<table width='100%' border='0' cellspacing='0' cellpadding='0'>								<tr>									<td class='p30-15' style='padding: 50px 30px;' bgcolor='#ffffff'>										<table width='100%' border='0' cellspacing='0' cellpadding='0'>											<tr>												<td class='text-footer1 pb10' style='color:#999999; font-family:Noto Sans, Arial,sans-serif; font-size:16px; line-height:20px; text-align:center; padding-bottom:10px;'>SmartSocial - Social Media Made By Leonardo Marchesini</td>											</tr>											<tr>												<td class='text-footer2 pb30' style='color:#999999; font-family:Noto Sans, Arial,sans-serif; font-size:12px; line-height:26px; text-align:center; padding-bottom:30px;'>Progetto elaborato per esame di stato 2021 - ITIS Zuccante - VE</td>											</tr>											<tr>												<td class='text-footer3' style='color:#c0c0c0; font-family:Noto Sans, Arial,sans-serif; font-size:12px; line-height:18px; text-align:center;'><a href='#' target='_blank' class='link3-u' style='color:#c0c0c0; text-decoration:underline;'><span class='link3-u' style='color:#c0c0c0; text-decoration:underline;'>Unsubscribe</span></a> from the newsletter.</td>											</tr>										</table>									</td>								</tr>							</table>						</td>					</tr>				</table>			</td>		</tr>	</table></body></html>",
    };

    const result = await transport.sendMail(mailOptions);
    return result;
  } catch (error) {
    return error;
  }
}

sendMail().then(result=> console.log('Email sent...', result)).catch(error => console.log(error.message));

const app = express();

const cors = require('cors');

app.use(helmet());

app.use(cors())

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", (req, res) => {
  res.json({ message: "Welcome to SmartSocial." });
});

require("./app/routes/account.routes.js")(app);
require("./app/routes/post.routes.js")(app);
require("./app/routes/comment.routes.js")(app);
require("./app/routes/interest.routes.js")(app);
require("./app/routes/vote.routes.js")(app);

app.listen(3000, () => {
  console.log("Server is running on port 3000.");
});