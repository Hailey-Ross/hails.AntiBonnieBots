integer MyChannel = 5050;
integer hasEstatePerm = FALSE;
list bannedBots;

default
{
    on_rez(integer start_param)
    {
        llResetScript();
    }
    changed(integer change)
    {
        if (change & CHANGED_OWNER)
            llResetScript();
    }
    state_entry()
    {
        llRequestPermissions(llGetOwner(), PERMISSION_SILENT_ESTATE_MANAGEMENT);
        llListen(MyChannel, "", llGetOwner(), "");
        llInstantMessage(llGetOwner(), llGetScriptName() + " is now Online in the " + llGetRegionName() + " Region.");
    }
    run_time_permissions(integer perm)
    {
        hasEstatePerm = (perm & PERMISSION_SILENT_ESTATE_MANAGEMENT) != 0;
        if (hasEstatePerm)
        {
            llInstantMessage(llGetOwner(), llGetScriptName() + " will suppress the default Estate Action notifications. \nSay /" + (string)MyChannel + " bonnie.help for Commands");
        }
        else
        {
            llInstantMessage(llGetOwner(), llGetScriptName() + " will not suppress the default Estate Action notifications. \nIf you find the default notifications annoying just reset/re-rez me ♥ \nSay /" + (string)MyChannel + " bonnie.help for Commands");
        }
        llSetTimerEvent(10.0);
    }
    listen(integer chan, string name, key id, string msg)
    {
        if (msg == "bonnie.reset")
        {
            llOwnerSay("Command acknowledged.");
            llResetScript();
        }
        else if (msg == "bonnie.help")
        {
            llOwnerSay(llGetScriptName() + " has the following commands:");
            llOwnerSay("bonnie.reset .............. Reset the Script");
            llOwnerSay("bonnie.help  ................ This help list");
        }
    }
    timer()
    {
        list agents = llGetAgentList(AGENT_LIST_REGION, []);
        integer count = llGetListLength(agents);
        integer i;
        for (i = 0; i < count; i++)
        {
            key user = llList2Key(agents, i);
            string username = llGetUsername(user);
            if (llSubStringIndex(username, "bonniebelle") != -1 &&
                llListFindList(bannedBots, [user]) == -1)
            {
                bannedBots += [user];
                if (hasEstatePerm)
                    llManageEstateAccess(ESTATE_ACCESS_BANNED_AGENT_ADD, user);
                llInstantMessage(user, "Hello " + username + ", \nyou have been Banned from the Simulator " + llGetRegionName() + " as you were detected to be a part of BonnieBots.com \nIf you believe this Ban has occurred in error, please contact the land owner via IM.");
                llInstantMessage(llGetOwner(), llGetScriptName() + " has Banned user: " + username + " \nFrom the " + llGetRegionName() + " Region. \nReason: Suspected BonnieBot");
            }
        }
    }
}
