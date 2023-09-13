# Fun with spoofing emails on your email server
$Parameters = @{
    SMTPServer = "SMTP Address"
    Port = 25
    To = "To Address"
    From = "DisplayName <e-mail address>"
    Priority = "Priority"
    Subject = "Subject"
    Body = "Insert message in HTML format"
    Attachments = "Possible file attachments, insert path here"
    BodyAsHtml = $true
    }

Send-MailMessage @Parameters