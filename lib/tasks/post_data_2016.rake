# frozen_string_literal: true

# run these tasks like:
# rake ingredients:task_name

namespace :posts do
  desc 'populate gratitude journal'
  task gratitude_2016: :environment do
    puts 'Populating 2016 gratitude journal...'

    user = User.first
    gratitude = user.post_types.find_by(name: 'Gratitude')

    Post.create!([
      { post_type_id: gratitude.id, date: '2016-01-01', description: "Our air mattress got a hole! and now we're searching for a mattress. it is so nice that i was able to arrange to borrow an air mattress asap while we found a replacement." },
      { post_type_id: gratitude.id, date: '2016-01-03', description: "last night was a super chill nye -- hanging out with sarah until 9:30 then heading home. not a big deal -- at all. and much appreciated." },
      { post_type_id: gratitude.id, date: '2016-01-05', description: "brunch this morning was delightful! so many people and conversations and fun and it was so nice to feel connected and invited." },
      { post_type_id: gratitude.id, date: '2016-01-07', description: "I wrote my first Instructable. It was for my air plant necklace project", url: "http://www.instructables.com/id/Wooden-Air-Plant-Necklace/" },
      { post_type_id: gratitude.id, date: '2016-01-09', description: "I sold a deck of Tiny Tarot Cards after doing a whole bunch of readings on New Years Day. So fun!" },
      { post_type_id: gratitude.id, date: '2016-01-11', description: "Just just bought a mattress! Holy crap. I am so looking forward to this." },
      { post_type_id: gratitude.id, date: '2016-01-13', description: "I just published the deck of Cats in Space cards that I made for Mike for Christmas ", url: "https://www.thegamecrafter.com/games/cats-in-space1" },
      { post_type_id: gratitude.id, date: '2016-01-15', description: "I just spent a couple of hours putting together a CV on StackOverflow. It was nice to be able to pool my posts in one place. ", url: "http://stackoverflow.com/jobs/cv/employer/355921" },
      { post_type_id: gratitude.id, date: '2016-01-17', description: "Went in for reiki at a new place. Loved her! Also ended the day with restorative yoga. So nice. End result: it's time to nurture my shriveled little inner goddess." },
      { post_type_id: gratitude.id, date: '2016-01-19', description: "I just published my 30 yoga tracks on Bandcamp! Nice! We'll see if any tracks sell.", url: "https://annerichardson.bandcamp.com/" },
      { post_type_id: gratitude.id, date: '2016-01-21', description: "I just published another instructable! This one is my clever new way to try to get votes for the betabrand campaign http://www.instructables.com/id/Ladies-Zipper-Pocket-Underpants/  Fingers crossed.", url: "http://www.instructables.com/id/Ladies-Zipper-Pocket-Underpants/" },
      { post_type_id: gratitude.id, date: '2016-01-23', description: "Milan took me around the FQ to talk to shop owners about selling my tarot cards. Though I didn't sell any cards, it was nice to have a person who was willing to help me so much because he wants to see me succeed." },
      { post_type_id: gratitude.id, date: '2016-01-25', description: "I launched a new app called ReactBetter and it is getting lots of traction on facebook. People are really into it and it feels nice to have made something that helps to build positive interactions in the world.", url: "http://reactbetter.herokuapp.com/" },
      { post_type_id: gratitude.id, date: '2016-01-27', description: "It's only January 15th and I have published 2 Instructables, 1 app, a Bandcamp album, and a new CV on stack overflow. I've been feeling cranky about not accomplishing anything worthwhile in my life, but that's because I haven't stopped to celebrate. I published a lot!" },
      { post_type_id: gratitude.id, date: '2016-01-29', description: "My ReactBetter app is an awesome tool! I'm already catching myself choosing to react in more productive ways." },
      { post_type_id: gratitude.id, date: '2016-01-21', description: "I've just ordered a stamp and embroidery pattern for the NOLA tiny tarot deck's velvet bags. Though I have no idea how this is going to turn out, it is an adventure that I am really enjoying." },
      { post_type_id: gratitude.id, date: '2016-01-23', description: "Though I was feeling sad that Zorro cat moved to Biloxi, I've been able to flip it around to feeling released of all of the heartache and people tension he also brought us while he was here. I miss him, but I am also glad he is gone. This feels so much better than being sad." },
      { post_type_id: gratitude.id, date: '2016-01-25', description: "My air plant necklace instructable came in 3rd place in the Indoor Gardening contest.", url: "http://www.instructables.com/contest/indoorgardening2015/" },
      { post_type_id: gratitude.id, date: '2016-01-27', description: "I just launched http://sorrygirl.herokuapp.com/ the app where you can write an apology and it comes from Ryan Gosling. It is hella fun.", url: "http://sorrygirl.herokuapp.com/" },
      { post_type_id: gratitude.id, date: '2016-01-05', description: "I had an excellent phone interview with a company I'd love to work for. Aside from the call going well with an excellent rapport, I had a big confidence boost in my relative abilities as a developer." },
      { post_type_id: gratitude.id, date: '2016-01-07', description: "I get to take Mickki to an Uptown parade tonight! #sharingfavethingswithfavepeople" },
      { post_type_id: gratitude.id, date: '2016-02-01', description: "My NOLA tiny & poker size tarot cards have all arrived and they look great! Using a stamp on the velvet bag works really well and the people I've shown them to really love them! Yay!" },
      { post_type_id: gratitude.id, date: '2016-02-05', description: "When I told people my plan to use a stamp on the tarot card bags, everyone was hesitant, but I knew it would be awesome and it was. I am glad I stuck with it instead of listening to those doubts and worrying." },
      { post_type_id: gratitude.id, date: '2016-02-10', description: "I just consigned 5 sets of tiny tarot & 3 poker size tarot to the sewing store. Yay!" },
      { post_type_id: gratitude.id, date: '2016-02-14', description: "I knew 2 people in parades this year. That was pretty cool!" },
      { post_type_id: gratitude.id, date: '2016-02-17', description: "Mike is in the shower singing songs out loud about kitties (complete with trumpet sounds). It makes me so happy to hear him being so playful!" },
      { post_type_id: gratitude.id, date: '2016-02-20', description: "Even though when Mickki and Dave came to visit, it was a terrible time which resulted in a fight, and I have spent a lot of time confused the next steps of our relationship, I am feeling grounded in who I am and am not worried about needing to be flexible to solve the problem." },
      { post_type_id: gratitude.id, date: '2016-02-13', description: "The new TMDB movie database project Mike and I are building is coming together really nicely. We're having some odd communication problems, but overall, we're working together really well." },
      { post_type_id: gratitude.id, date: '2016-02-23', description: "I just completed a full week of working full time. I'm exhausted but I love my coworkers." },
      { post_type_id: gratitude.id, date: '2016-02-15', description: "It has been a couple of weeks since the Mickki breakup and I feel fine. I don't feel any hole in my heart, and in fact, I still feel lighter. I think this is a good sign." },
      { post_type_id: gratitude.id, date: '2016-02-07', description: "I have started my first outsourced design project by having Andres do a Mobius logo. This is all new to me and I am looking forward to the learning and growth that may happen here." },
      { post_type_id: gratitude.id, date: '2016-02-24', description: "I have a handful of design work to do for Colfax On The Hill and I am totally over it. It feels nice to have taken big steps to improve my career so that I'm not working on design work like this as my primary income." },
      { post_type_id: gratitude.id, date: '2016-02-18', description: "On Friday, I left my laptop in the office knowing I wouldn't have to even think about it until Monday morning. This feels very liberating." },
      { post_type_id: gratitude.id, date: '2015-03-01', description: "I spend a lot of my time feeling like I am under-qualified. However, I have already heard about other new developers feeling like an imposter, so I know that this is what I am experiencing. Though the feeling feels like my own unique failure, it is just part of the process and I am doing fine if I just keep doing the work." },
      { post_type_id: gratitude.id, date: '2016-03-05', description: "Every day I commute by bike, I smile and say hello to everyone I pass. This leaves me feeling so happy!" },
      { post_type_id: gratitude.id, date: '2016-03-10', description: "I experienced my first set of company team building events and I feel like I got to know people better. This was really nice." },
      { post_type_id: gratitude.id, date: '2016-03-15', description: "The St Patrick's Day Parade was rerouted to go up Napoleon (yay!) and I caught a coveted cabbage! We cooked it for dinner last night." },
      { post_type_id: gratitude.id, date: '2016-03-20', description: "Went to hack night last night and had a great time! As usual, I only knew a couple of people, but the new people were super fun to talk to." },
      { post_type_id: gratitude.id, date: '2016-04-01', description: "Today at work, I accidentally did work on the master branch of a small project, then pushed those changes to the shared repo. This is a tragically bad kind of mistake to make. I felt big dread and then immediately put my big girl pants on told my boss what I had done. I could have panicked, I could have groveled. But I handled it professionally to the best of my ability and I'm pretty proud of myself for it." },
      { post_type_id: gratitude.id, date: '2016-04-04', description: "Mike went to a Ruby conference in Florida this week and he's enjoyed his adventure!" },
      { post_type_id: gratitude.id, date: '2016-04-08', description: "Napoleon kitty down the street is always happy to pop up from a nap and come over for some pettins. He also likes to try to get on a lap for even more pettins. Damn he's cute." },
      { post_type_id: gratitude.id, date: '2016-04-12', description: "I have been practicing my bike commute & smile mornings for over a month. It has become so rewarding. When I get those return smiles, wow it's like a blast of love." },
      { post_type_id: gratitude.id, date: '2016-04-14', description: "I am feeling like a stronger biker. I like the way my legs and body feel -- stronger, sexier, more purposeful." },
      { post_type_id: gratitude.id, date: '2016-04-18', description: "This awesome Betabrand comment: 'After reading about these bloomers, I got your book and gobbled it up. It inspired me so much I am having my REI Skreeline pants and capris, American Giant hoodie, AND Beta Brand Bike-to-Work jacket all McGyvered (now known as Richardsoned). I'd love to share my hacks, since you obviously get lady travel clothing and have kickin' style. Someone has to free us all from ugly, useless travel clothing -- I nominate you'" },
      { post_type_id: gratitude.id, date: '2016-04-18', description: "Netherlands games order for 200 decks!" },
      { post_type_id: gratitude.id, date: '2016-04-20', description: "Found a new printer to handle big orders and I like the quality of the product they produce." },
      { post_type_id: gratitude.id, date: '2016-04-12', description: "Mike had a satisfying technical interview where he got to talk about his code and it felt really nice." },
      { post_type_id: gratitude.id, date: '2016-04-22', description: "Really enjoyed our little road trip out to Thibideaux to visit a distillery where they made some really delicious cocktails the drive was beautiful and we seemed to have missed some seriously show-stopping traffic both ways." },
      { post_type_id: gratitude.id, date: '2016-04-15', description: "Sat out on the back porch last night and the weather was beautiful. Mike had his guitar and it was just really nice. Spring is so beautiful." },
      { post_type_id: gratitude.id, date: '2016-04-18', description: "Spent Friday evening in perfect weather on the back porch. I drank wine and painted until it got too dark and the mosquitoes became too annoying. It was so lovely!" },
      { post_type_id: gratitude.id, date: '2016-05-15', description: "Met Mike & Abby Belasco at Jazz Fest yesterday. It was nice to see them. The weather was so bad, the whole area flooded and they actually cancelled the rest of the day. This was so disappointing because we wanted to see Snoop & Beck. However, the weather was terrible and we were lucky enough to be inside a safe tent. We were able to leave the event with no more damage than being wet and a little muddy. Adventure!" },
      { post_type_id: gratitude.id, date: '2016-05-15', description: "Couldn't make it to brunch at Sarah's today, but she sent me home with strawberry shortcakes. Mmm. It is nice to feel taken care of." },
      { post_type_id: gratitude.id, date: '2016-05-15', description: "Mike got a remote rails jr developer position!" },
      { post_type_id: gratitude.id, date: '2016-05-15', description: "We spent an awesome day at veggie fest and the french quarter." },
      { post_type_id: gratitude.id, date: '2016-05-24', description: "I am feeling grateful for the coworkers I get to work with. They're interesting and driven." },
      { post_type_id: gratitude.id, date: '2016-05-12', description: "I am feeling grateful for my long relationship with my husband. We've known each other since 2002 and are still getting to know each other as we grow and change. What a gift." },
      { post_type_id: gratitude.id, date: '2016-05-24', description: "I had a fun and playful sibling summit phone call this week. We got to connect and that feels good." },
      { post_type_id: gratitude.id, date: '2016-05-24', description: "Went to the Bayou Bugaloo and loved how so many people we out floating on Bayou St John in homemade contraptions. So much festiveness and silliness." },
      { post_type_id: gratitude.id, date: '2016-05-03', description: "Mike had a really rough week of problems with git. I was able to help him through some of the basic stuff -- which was good -- but also a great indicator of how much I have been learning even though I feel like I don't know anything." },
      { post_type_id: gratitude.id, date: '2016-05-03', description: "I had been feeling very very depressed and I used my mental workout skills to climb out successfully. This includes: self compassion, forcing myself to smile and say hello to strangers, taking time to do plow pose and listen to music, doing a little meditation." },
      { post_type_id: gratitude.id, date: '2016-05-17', description: "I've taken my morning hellos to the next level by now intending to stop and talk to the people I pass. So far I have met George the veterinarian and her two dogs Floyd and Loud Mouth Abby" },
      { post_type_id: gratitude.id, date: '2016-06-01', description: "I'm grateful that we didn't have to deal with a hurricane in 2015. Also, now that we're better connected, hopefully dealing with one (some?) this year will be safer." },
      { post_type_id: gratitude.id, date: '2016-06-05', description: "Setting my ego aside, I have been reading The Life-changing Magic of Tidying Up and have been loving how the author and I have had separate and very similar experiences. Plus, I even let myself learn some things from her. #lettinggo" },
      { post_type_id: gratitude.id, date: '2016-06-10', description: "Friday night after-dinner drinks at carlaYbobshaw's house was really nice! Hanging out with people is so fun sometimes. This was one of those times." },
      { post_type_id: gratitude.id, date: '2016-06-15', description: "I just got a shiny new bike helmet. That was cool." },
      { post_type_id: gratitude.id, date: '2016-06-20', description: "I was able to teach Jacqui how to use Illustrator so she can redraw a logo. It was nice to be able to be on the teaching side of new information these days." },
      { post_type_id: gratitude.id, date: '2016-06-26', description: "We just got a kiddie pool for the backyard and it is awesome!" },
      { post_type_id: gratitude.id, date: '2016-07-10', description: "I have been feeling pretty emotionally good last week and this week. That is nice." },
      { post_type_id: gratitude.id, date: '2016-07-21', description: "I've spent evenings working on a rails app at home. It's been a while since I've felt like I've had the capacity to do any thought work at night. It is nice to get back to it." },
      { post_type_id: gratitude.id, date: '2016-08-05', description: "I hadn't understood params in rails and it was a block for me. However, since doing so many var_dumps at mudbug, i was able to revisit params in rails and understand them completely. It is nice to see progress!" },
      { post_type_id: gratitude.id, date: '2016-08-23', description: "We were glad to see little mindykitty get a collar around her neck. She's got a home now. <3" },
      { post_type_id: gratitude.id, date: '2016-09-07', description: "Yesterday lightning struck a high voltage power line and the whole of uptown was out of power. There were so many neighbors out on the street it was so fun connecting with people." },
      { post_type_id: gratitude.id, date: '2016-09-14', description: "I've been working on a productmatchr project with Kevin and Andrew and it is really nice to feel useful! As it turns out, i do know things and i'm pretty good at some of them. It's also really interesting to *not* be the designer on this project." },
      { post_type_id: gratitude.id, date: '2016-09-20', description: "The lightbulbs in the fridge stopped working correctly, which resulted in heating the fridge to warmer than room temp. They melted the casing. So glad it didn't burn the house down!" },
      { post_type_id: gratitude.id, date: '2016-09-29', description: "We all got together to celebrate Ray's 70th birthday together in a big beach house in Delaware. We all had a pretty good time. I struggled a bit with not liking who I am around my family. It is fascinating to be able to witness that experience. It is also nice to be away from it again." },
      { post_type_id: gratitude.id, date: '2016-10-01', description: "The weather has turned into a lovely less-humid version of summer. Even though I feel the dread of winter coming, I just love how wonderful it feels to be outside." },
      { post_type_id: gratitude.id, date: '2015-10-05', description: "Hurricanes keep rolling in, but we haven't had to evacuate yet. Fingers crossed on that one." },
      { post_type_id: gratitude.id, date: '2016-10-10', description: "I've been writing a lot of good code and solving problems. It is so nice to see progress. Yesterday i knocked out a bunch of little to-dos in my RestaurantQueue app that were things beyond my skills previously. Totally doable now." },
      { post_type_id: gratitude.id, date: '2016-10-15', description: "I just started Martha Beck's Steering by Starlight and I really like it! It feels good to get organized and truthful about what I want to experince in my life." },
      { post_type_id: gratitude.id, date: '2016-10-20', description: "This fall weather has been beautiful! Though I dislike breaking out my slippers, it is really delightful to be outside for as long as we please without it being too hot." },
      { post_type_id: gratitude.id, date: '2016-10-25', description: "I'd also like to celebrate that I am not having a daily struggle anxiety and depression. I feel really good!" },
      { post_type_id: gratitude.id, date: '2016-10-31', description: "I got to do tarot card readings at Peaches Records for Halloween weekend and had a really great time with it." },
      { post_type_id: gratitude.id, date: '2016-11-05', description: "I have had the chance to work through some life planning with a book. I have enjoyed the process." },
      { post_type_id: gratitude.id, date: '2016-11-15', description: "We've had some really delightful weather for the past few weeks. So crisp and sunny. Really really nice." },
      { post_type_id: gratitude.id, date: '2016-11-20', description: "In a couple of weeks I get to make pickles with friends. Yay!" },
      { post_type_id: gratitude.id, date: '2016-12-13', description: "I got an email from a dentist who wanted to quote a blog post I wrote for A Shifted Perspective. She's producing a floss dispenser with refillable cartridges and wanted to use a quote on a calculation i made of waste produced by floss containers. How cool is that?" },
      { post_type_id: gratitude.id, date: '2016-12-01', description: "I really wanted to figure out how to do a low-maintenance christmas tree this year and was delighted to find the canvas Ikea wall hanging. It has made our home feel so much merrier this year." },
      { post_type_id: gratitude.id, date: '2016-12-04', description: "I've seen Kiffie twice now since she moved to Florida and visited NOLA. It's so nice spending time with her. We get to talk about bodies and food and steps toward maintaining health." },
      { post_type_id: gratitude.id, date: '2016-12-05', description: "Making little paper chains and decorating the house brings me so much joy. This year's big chain + little chain combo hanging in the living/bedroom doorway was just a delight." },
      { post_type_id: gratitude.id, date: '2016-12-10', description: "We've recently made a couple of improvements to our living space: a towel bar for me, a magnet in the shower curtain, a floor lamp instead of a desk lamp, silicone dish cover instead of foil, a toaster oven that does not burn us, and a foot warmer for Mike in the living room." },
      { post_type_id: gratitude.id, date: '2016-12-10', description: "After nearly a year of posture practice, my posture is much better and even has been noteworthy to a couple of people." },
      { post_type_id: gratitude.id, date: '2016-12-15', description: "December: I'm re-appreciating my whiteboard purchase. It's been a really valuable tool for me to do some thinking, tinkering and figuring out of things." },
      { post_type_id: gratitude.id, date: '2016-12-20', description: "December: Sometimes I really love meeting strangers and connecting. Last night I met a guy in line for the taco truck (which — FINALLY we got to try and it was gooood!) because I told him how beautiful i thought his necklace was. He told me about his friend who made it and the meteor that was in it. It just feels nice to connect to other people and hear about what they love." },
      { post_type_id: gratitude.id, date: '2016-02-07', description: "Take & Bake is kind of a miracle. I can appreciate each vegetable topping, but then there is the whole process behind the sauce, the cheese, and the crust. That's some seriously evolved food preparation. And we just get to pop it in our oven." },
      { post_type_id: gratitude.id, date: '2016-07-15', description: "Last week I had a big old chunk of glass in my tire. I had an instant flat. I replaced the tube, but then a few days later, the tube started herniating out of the tire liner and the tire itself. Holy crap! My tire was posed to shred open at any time. I bought new tires online and didn't get to change them until this weekend. I rode on that danger tire for 4 days and it didn't explode. Phew!" },
      { post_type_id: gratitude.id, date: '2016-06-05', description: "Toaster oven. Enough said." },
      { post_type_id: gratitude.id, date: '2016-02-15', description: "White board for thinking" },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "Having safe space to sing out loud or play guitar is very satisfying. Not having this space feels very constricting." },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "I need to continue to follow my instinct. When I do, things work out and it is very satisfying." },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "When I follow my passion and I create products and content, I usually tell myself that these things are insignificant or that no one cares. As it turns out, sometimes people do and what I've created and shared brought someone joy or the data they need to help sell their sustainable floss. When I do good work that I care about, good things are happening. I just don't always get to see it — but that doesn't mean i shouldn't do it. Ex: betabrand comment about book, floss post, positive reaction to ReactBetter app" },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "Doing work every day on specific skills does pay off. Ex: good posture, meditation, git, happiness exercises especially under duress." },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "Do not take for granted a calm and confident emotional state" },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "Making little changes to our living space that make life a little nicer, easier, or sweeter makes a really significant boost in my happiness. Ex: towel bar, kitchen knife, whiteboard, kiddie pool, shower magnets, toaster oven." },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "It is time to seriously chase some of the products I create" },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "Investing in a nicer wardrobe and dressing more nicely makes me feel good about myself" },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "I've witnessed how i am different around my family. I don't like that version of myself. This is worth exploring or just being aware of so that i'm not too hard on myself." },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "I am just beginning to do a better job of drawing boundaries. This is hard and i need to keep doing it. My lack of setting boundaries is a major contributor to why my relationship with Mickki needed to end." },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "Drawing boundaries around work and personal time will help me to squash that ever present feeling of not being productive enough." },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "I do produce a lot of products and tend to forget that regularly. Celebrating my posts helps me to recognize my own value. How would great grandpappy talk about himself? I need to do that." },
      { post_type_id: gratitude.id, date: '2016-12-31', description: "There is always work to be done in maintaining and improving my relationship with Mike. I am grateful to have this opportunity." },

    ])
    puts "Gratitude Posts count: #{gratitude.posts.count} "
    puts 'Done'
  end

end