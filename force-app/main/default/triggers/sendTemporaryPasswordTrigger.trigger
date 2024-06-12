trigger sendTemporaryPasswordTrigger on Contact (after insert) {
    try {
        for (Contact newContact : Trigger.New) {
            // Send password email
            sendTemporaryPasswordHelper.sendTemporaryPasswordEmail(new List<Contact>{newcontact});
        }
    } catch (Exception e) {
        System.debug('Error sending email: ' + e.getMessage());
    }
   
}