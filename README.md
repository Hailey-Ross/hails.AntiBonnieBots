# hails.AntiBonnieBots

Automatically detect and ban BonnieBot avatars from your Second Life region.

BonnieBots are automated bot accounts identified by the username prefix `bonniebelle`. This script scans all agents in the region every 10 seconds, identifies any matching that pattern, and bans them from the estate, notifying both the bot and the land owner via IM.

---

## What You'll Need:

- **A Second Life region where you hold Estate Manager or Estate Owner rights**
- **The object containing this script must be owned by the estate owner**
- **Estate management permissions must be granted when prompted**

---

## How It Works

1. On rez or reset, the script requests `PERMISSION_SILENT_ESTATE_MANAGEMENT`
2. Once the permission dialog is resolved, it begins scanning the **entire region** every **10 seconds**
3. Every detected agent's username is checked for the string `bonniebelle`
4. If a match is found and has not already been actioned this session:
   - The avatar is added to the estate ban list via `llManageEstateAccess`
   - The bot receives an IM explaining the ban and how to appeal
   - The owner receives an IM confirming the ban
5. Already-processed keys are tracked per session to prevent duplicate actions on the same avatar

> If `PERMISSION_SILENT_ESTATE_MANAGEMENT` is **not** granted, the script will still run and notify you of detected bots, but it will **not** be able to ban them or suppress the default estate action popups.

---

## Setup

### 1. Rez the Object

Place the object containing `hails.AntiBonnieBots.lsl` in your region.

---

### 2. Grant Permissions

When prompted, grant the **Estate Management** permission. This allows the script to:

- Add avatars to the estate ban list silently
- Suppress the default estate action notification popups

---

### 3. Confirm Online

You will receive an IM from the script:

    hails.AntiBonnieBots is now Online in the [Region Name] Region.

The script is now actively scanning.

---

## Commands

Commands are spoken on channel `/5050` and are restricted to the object owner only.

| Command | Description |
|---|---|
| `bonnie.reset` | Resets the script |
| `bonnie.help` | Displays the command list |

**Example:**

    /5050 bonnie.reset

---

## Notifications

### When a bot is detected and banned:

**Owner receives:**

    hails.AntiBonnieBots has Banned user: bonniebelle1234
    From the [Region Name] Region.
    Reason: Suspected BonnieBot

**Bot receives:**

    Hello bonniebelle1234,
    you have been Banned from the Simulator [Region Name] as you were detected
    to be a part of BonnieBots.com
    If you believe this Ban has occurred in error, please contact the land owner via IM.

---

## Notes

- **Mono compilation is recommended.** Open the script in the SL editor and ensure the **Mono** checkbox is ticked before saving. Mono gives the script a 64 KB memory limit vs. the 16 KB LSO default.
- The banned-bots list is session-based: it clears on reset, but the estate ban itself persists
- Scans the **entire region** with no range limit, using `llGetAgentList`
- The script does not announce every avatar in range, only BonnieBot detections trigger notifications

---

## Common Mistakes

- Rezzing the object without estate owner/manager rights
- Declining the permission prompt: bans will not function without it
- Placing the script in an object owned by a different account than the estate owner

---

Enjoy,
Hails❤️
