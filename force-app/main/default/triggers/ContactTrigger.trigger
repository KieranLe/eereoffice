trigger ContactTrigger on Contact (after insert) {
    // Loop through each new contact and create a community user
    for (Contact newContact : Trigger.New) {
        CommunityUserHelper.createCommunityUser(newContact);
    }
}