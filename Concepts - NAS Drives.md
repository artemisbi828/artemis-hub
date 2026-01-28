
![An older enthusiast motherboard that would make an ideal home server or NAS.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2025/11/52675662149_dd10c0c7a4_o.jpg?&fit=crop&w=1600&h=900)Credit: Jason Fitzpatrick / How-To Geek

[![4](https://static0.howtogeekimages.com/wordpress%2Fwp-content%2Fauthors%2F64ca808a79651-IMG-20230316-WA0002.jpg?fit=crop&w=90&h=90)](https://www.howtogeek.com/author/nicklewis/)

By [Nick Lewis](https://www.howtogeek.com/author/nicklewis/)


Nick Lewis is an editor at How-To Geek. He has been using computers for 20 years --- tinkering with everything from the UI to the Windows registry to device firmware. Before How-To Geek, he used Python and C++ as a freelance programmer. In college, Nick made extensive use of Fortran while pursuing a physics degree.  
  
Nick's love of tinkering with computers extends beyond work. He has been running video game servers from home for more than 10 years using Windows, Ubuntu, or Raspberry Pi OS. He also uses Proxmox to self-host a variety of services, including a Jellyfin Media Server, an Airsonic music server, a handful of game servers, NextCloud, and two Windows virtual machines.  
  
He enjoys DIY projects, especially if they involve technology. He regularly repairs and repurposes old computers and hardware for whatever new project is at hand. He has designed crossovers for homemade speakers all the way from the basic design to the PCB.  
  
 Nick enjoys the outdoors. When he isn't working on a computer or DIY project, he is most likely to be found camping, backpacking, or canoeing.

A network attached storage device (NAS) is one of the most useful things you can add to your home network, but a specialized NAS can run you hundreds of dollars just for the shell, and that is before you even buy additional hard drives for storage. If you want a large, robust NAS, you'll be on the hook for even more.

That is why I built my own NAS for a fraction of the cost using components from an old PC and some used pieces I bought on the internet for half off.

## Fixing up an old PC to use as a NAS

Despite how much off-the-shelf NAS units cost, you don't actually need particularly powerful hardware to do almost anything you might want. Any computer made in the last ten years will do the job. An old Dell Optiplex is a popular starting device because you can often get them for next to nothing or free. I repurposed an old gaming PC with a Ryzen 1600x, 24GB of RAM, and an old GTX 1060 for my NAS since I had most of the parts already.

If you already have a PC on hand, then just stick with that for your NAS. If you're on the used market, I'd recommend trying to pick up something with an Intel processor rather than AMD. Intel processors have a technology called QuickSync, which enables them to very [efficiently transcode video files](https://www.howtogeek.com/750701/why-hardware-transcoding-is-important-on-a-nas/).

If you're planning on streaming video using your NAS, then QuickSync is definitely a feature you want.

If you have an AMD processor, you can always add an inexpensive GPU to your PC that will handle any kind of video transcoding that you might need to do.

### Add an SSD for the boot drive

If you pick up a used PC from Facebook Marketplace or elsewhere, it may not come with a hard drive—a lot of people remove them before selling or getting rid of a PC to ensure their data is secure.

In general, you want to get the fastest boot drive you can. If you search for the motherboard model of the PC you're working with, the manual will specify what kind of NVMe drive you can use, if it supports one at all.

![A straight-on shot of the Crucial T710, Samsung 9100 Pro, and Samsung 990 EVO Plus NVMe SSDs mounted to a motherboard.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2025/08/a7308455.jpg?q=49&fit=crop&w=825&dpr=2)Credit: Patrick Campanale / How-To Geek

If it doesn't, that isn't a huge problem. SATA SSDs are still plenty fast enough for a NAS setup. My NAS still uses a SATA SSD because I found one for cheap. I haven't needed to replace it.

### Get extra RAM

I'd recommend TrueNAS or Unraid as operating systems for your NAS. Both need 8GB of RAM as a starting point. If you want to run virtual machines or containers (like with Docker) on your NAS, I'd aim for 16GB or more. The system I'm using started with 16GB of RAM, but I added another 8GB (2x4GB) for about $10 by buying some used RAM from Facebook marketplace.

![An older gaming motherboard with four sticks of RAM.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/2025/11/52675805605_e050a2b3f7_o.jpg?q=49&fit=crop&w=825&dpr=2)Credit: Jason Fitzpatrick / How-To Geek

If you've picked up a PC you don't know much about, you can always search for the motherboard make and model on the internet to find out the type of RAM it takes, or pull out one of the current RAM sticks. There is usually a sticker on the side that tells you the make, type, and speed.

If you do buy used RAM, make sure you're getting at least a 50% discount, and be sure to give the RAM a once-over physically to make sure that there aren't any obvious signs of damage.

### Buy hard drives cheap

Keeping with the theme of buying used old computer parts to save, I built my NAS with refurbished drives from [ServerPartDeals](https://serverpartdeals.com/), but you can also sometimes find good deals on Amazon.

In general, you can save about 50% off the normal sale price if you [buy a drive manufacturer recertified or refurbished](https://www.howtogeek.com/how-to-get-hard-drives-for-cheap/).

I now have a total of four recertified hard drives running in my system, the oldest of which have been in nearly continuous use in 2019. So far, none of them have shown any signs of problems.

If you aren't comfortable with that, you can always buy them new.

Whatever you buy, I'd weigh the benefits of buying specialized NAS drives instead of regular drives. In theory, they should last longer. Ultimately, I didn't because my NAS sees only light use, but if you plan on putting a lot of miles on your system, it may be worth it.

![A HGST 12TB Helium recertified hard drive.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/wm/2025/03/hgst-12tb-hdd.png?q=49&fit=crop&w=220&h=182&dpr=2)Related

##### [Please stop putting desktop hard drives in your NAS](https://www.howtogeek.com/buying-your-first-nas-be-sure-to-get-the-right-hdds/ "Please stop putting desktop hard drives in your NAS")

Don't start your NAS journey off on the wrong foot.

[65](https://www.howtogeek.com/buying-your-first-nas-be-sure-to-get-the-right-hdds/#threads "Total Posts")

By [Patrick Campanale](https://www.howtogeek.com/author/patrick-campanale/ "Posts by Patrick Campanale")

Nov 21, 2025

## Choose the right operating system

There is nothing that stops you from using any Linux distro, or even Windows, as a NAS operating system. However, most of those options involve manually installing and configuring a ton of things.

Instead, I'd recommend installing [TrueNAS](https://www.truenas.com/) or [Unraid](https://unraid.net/) (which is paid), which are Linux distros designed specifically for use in a NAS. They handle most of the tedious (and sometimes complicated) stuff behind the scenes. Since my goal was to keep costs as low as possible, I went with TrueNAS.

I used Rufus to [create a bootable TrueNAS USB drive](https://www.howtogeek.com/how-to-make-a-bootable-linux-usb-drive-on-pc-or-mac/), then inserted it into my NAS PC. You will need a keyboard and display to connect to it, at least temporarily.

![Creating a bootable TrueNAS USB drive using Rufus.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/2025/11/trunas-on-rufus.png?q=70&fit=crop&w=825&dpr=1)

The installer will walk you through most of the setup—you don't need to do much since the default settings are fine. Just make note of your admin password, you'll need it later.

Once it is installed, you'll be able to access the NAS through the web browser of any device on your network by typing in the IP address, which is always displayed on your TrueNAS server. Alternatively, you could log in to your router to find your NAS's IP address.

![The IP address of the TrueNAS server.](https://static0.howtogeekimages.com/wordpress/wp-content/uploads/2025/11/the-ip-address-of-the-truenas-server.png?q=70&fit=crop&w=825&dpr=1)

From the web interface, you can manage your storage pools, add and remove containers or virtual machines, add apps, and do most anything else. For the most part, TrueNAS does a good job making everything approachable.

I'd recommend starting with creating an SMB share so your NAS is accessible from any Windows device on the network. That is the option I use most frequently myself.

I'd also strongly recommend one of the backup apps (like Duplicati) that comes with TrueNAS, too. Proper backups are essential in the digital era, and a cobbled-together NAS can be one part of a robust backup solution for your PC.

---

When you first create your NAS, make sure you figure out how to create a backup of your data _before_ you upload everything to it and cancel your Google Photos subscription. Remember, a NAS is only part of [a comprehensive backup plan](https://www.howtogeek.com/the-biggest-backup-mistake-everybody-makes-and-how-to-avoid-it/), and it won't do you any good if you don't take the proper steps to ensure the data on your NAS is properly backed up, too.

[](https://www.google.com/preferences/source?q=howtogeek.com)

# **Google is updating how articles are shown.** Don't miss our industry-leading content, written by humans, by setting [How-To Geek as a preferred source](https://www.google.com/preferences/source?q=howtogeek.com).