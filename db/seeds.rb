# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Announcement.create(text: 'Hello!!!!! second announcement!!')
Announcement.create(text: 'Hello!!!!!!! First announcement!!!')

User.create!([
  {email: 'admin@admin.admin', password: 'password'}
])

Quote.create(approved:true, text:
'<Cthon98> hey, if you type in your pw, it will show as stars
<Cthon98> ********* see!
<AzureDiamond> hunter2
<AzureDiamond> doesnt look like stars to me
<Cthon98> <AzureDiamond> *******
<Cthon98> thats what I see
<AzureDiamond> oh, really?
<Cthon98> Absolutely
<AzureDiamond> you can go hunter2 my hunter2-ing hunter2
<AzureDiamond> haha, does that look funny to you?
<Cthon98> lol, yes. See, when YOU type hunter2, it shows to us as *******
<AzureDiamond> thats neat, I didnt know IRC did that
<Cthon98> yep, no matter how many times you type hunter2, it will show to us as *******
<AzureDiamond> awesome!
<AzureDiamond> wait, how do you know my pw?
<Cthon98> er, I just copy pasted YOUR ******\'s and it appears to YOU as hunter2 cause its your pw
<AzureDiamond> oh, ok.')

Quote.create(approved: false, text: '<erno> hm. I\'ve lost a machine.. literally _lost_. it responds to ping, it works completely, I just can\'t figure out where in my apartment it is.')

Quote.create(approved: true, flagged: true, text: '<jeebus> the "bishop" came to our church today
<jeebus> he was a fucken impostor
<jeebus> never once moved diagonally')

Quote.create(approved: true, text: '< nutbar> [root@linux!/usr/src/bind] grep "{" named.conf.newer | wc -l
< nutbar>   19314
< nutbar> [root@linux!/usr/src/bind] grep "}" named.conf.newer | wc -l
< nutbar>   19313
< nutbar> [root@linux!/usr/src/bind]
< nutbar> great
* nutbar fumes
< nutbar> one fucking missing }')

Quote.create(approved: true, text: '<GaRlic> how you like my new name?
<drunkers> it stinks')
Quote.create(approved: true, text: '<danie2> do you have a gf?
<ieatrocks> hahahahahah
<ieatrocks> wow, thanks for even asking.')
Quote.create(approved: true, text: '<VolteFace`> don\'t you hate it when you shit on the floor, and you can hear it fall but you have no idea where it actually landed, and spend like 5 minutes looking for it
<peng> ...
<peng> what?
<VolteFace`> oh shit
<VolteFace`> don\'t you hate it when you DROP shit')
Quote.create(approved: true, text: '<fppe> The worst thing about a prostate exam is when he finds out you\'re not a real doctor.')
Quote.create(approved: true, text: '<ednos> technically, I\'m not pedantic')
Quote.create(approved: true, text: '<tttb> Why did the programmer quit his job?
<tttb> because he didn\'t get arrays')
Quote.create(approved: true, text: '<@apexthief> Okay we have taco tuesday I need other food day of the week ideas
<@AltRhombu> taco wednesday
<@AltRhombu> taco thursday')
Quote.create(approved: true, text: '<Papa_Wa> Anyone else struggling to login?
<Udungoof> i\'m struggling most of the time
<Udungoof> not necessarily with loginservers though
<Udongoof> life mostly')
Quote.create(approved: true, text: '')
Quote.create(approved: true, text: '')
Quote.create(approved: true, text: '')
Quote.create(approved: true, text: '')
Quote.create(approved: true, text: '')
Quote.create(approved: true, text: '')
Quote.create(approved: true, text: '')
