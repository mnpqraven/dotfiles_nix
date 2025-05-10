# Gaming

**NOTE**: remember my milage on gaming will be way less than other users considering
I'm still using Windows dualboot to game and have not done much on configuring on linux.
Do your on research

So far gaming has been actually pretty smooth, I have not encountered a many hurdles
to get gaming up and running (granted I've only tried a very few amount of games).
Still, not everything is playable to what I've been trying to get it working,
one of them is mainly games using kernel-level anti cheats.

## Running Steam games
Steam games can be run pretty smooth with just Proton being enabled

## Running non-Steam games
To run non-Steam games, add the `.exe` binaries to Heroic game launcher. You might need to change a few configs with wine to get them running:

- Wine version: If the `Wine Default` version doesn't work, try `wine-ge`
- Missing fonts: missing fonts can lead to blank text or crashing, install them with `Winetricks` -> install `allfonts` component

