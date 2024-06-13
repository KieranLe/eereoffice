String ouremail = 'britney@smith.com';
try {
    User[] queryUser = [SELECT Id, Name FROM User WHERE Email = :ouremail LIMIT 1];

    if (queryUser.size() > 0) {
        Id userId = queryUser[0].Id;
        System.setPassword(userId, '1234welcome');
        System.debug('Password successfully updated for user: ' + userId);
    } else {
        System.debug('No user found with email: ' + ouremail);
    }
} catch (Exception e) {
    System.debug('An error occurred: ' + e.getMessage());
}
