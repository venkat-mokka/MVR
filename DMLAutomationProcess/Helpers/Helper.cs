using System.Net.Mail;

public static class Helper
{
    public static void SendMail(string smtpUsername, string smtpPassword, string to, string Host, int Port, bool EnableSsl, string subject, string body, string displayName, string Cc_Email = null)
    {
        MailAddress frm = new MailAddress(smtpUsername, displayName);
        MailAddress t = new MailAddress(to, displayName);
        var msg = new MailMessage(frm, t);
        msg.Subject = subject;
        msg.Body = body;

        if (!string.IsNullOrEmpty(Cc_Email))
        {
            // Add a carbon copy recipient.

            msg.CC.Add(Cc_Email);
        }
        msg.Priority = MailPriority.High;
        msg.IsBodyHtml = true;
        msg.DeliveryNotificationOptions = DeliveryNotificationOptions.OnSuccess;
        ThreadStart threadstart = delegate ()
        {
            try
            {
                var client = new SmtpClient() { Timeout = 200000, Host = Host, Port = Port, EnableSsl = EnableSsl, UseDefaultCredentials = true, Credentials = new System.Net.NetworkCredential(smtpUsername, smtpPassword) };
                client.Send(msg);
            }
            catch (Exception ex)
            {
            }
        };
        Thread thread = new Thread(threadstart) { };
        thread.Start();

    }

}