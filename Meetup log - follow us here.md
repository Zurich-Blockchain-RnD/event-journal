## 2019-02-16

After taking a long break over the new year we had a couple of meetups at Digicomp which started hosting us before the years end. A management change made us look for alternatives once again and we're very glad we did. Thanks to our member Ilda, we formed a collaboration with Chainwork AG, a new major player in Zurich which will host us as part of their effort to hopefully lead part of the Swiss blockchain community. In order to scale our group, we transformed our repository into a GitHub organization which will allow teams to form per topic of interest and allow for cross collaboration between teams. Each team will own a repository which they will have control of. The general public will be able to collaborate with these teams as well by forking their repositories and creating pull requests. We will also be integrating as many aspects of the agile development method across our organization as possible so each team can collaborate effectively over whatever time period they choose and tackle tasks as their own chosen pace while maintaining progress. We will try to document as much of our research and development in our public GitHub repositories to benefit our other teams and the rest of the world. Slack will be used to communicate between teams while bots will update their threads with changes from GitHub and from the agile management system. That way the chats will give them a full overview of their project’s progress and a way to communicate and collaborate with everyone else. We’re very exited and are looking forward to implementing this new system across our evolving organization. We also posted our event on Eventbrite, created a LinkedIn group, a Twitter account and much more as we get ready to scale. Wish us luck and we hope to see you at our events or to collaborate with you remotely

## 2018-10-03

This meetup was focused on learning solidity and web3.
We took the skeleton contract that was created in the previous Saturday meetup and dressed it with some organs. :P
We once again, broke the session up into teams where most of us worked on the implementing the smart contract while Chris focused on beginning to implement some of the front end elements we distinguished in the mockups during the Saturday meetup.
The team that began to implement some of the functions in the smart contract, rearranged some of the data structures to accommodate the notorious limitations of solidity and it was somewhat comical I'd say.

You can find the history of this file [here](https://github.com/RealizingBlockchain/Payment-Infrastructure/commits/master/backend/contracts/payments.sol).

We'll try to add more comments beside the code to make the process more understandable and educational.

## 2018-09-29

As our meetups mature and our objectives become clearer, we're able to get down to coding much faster.
First, we took some time to discuss what we wanted to achieve in this session, then we separated into groups according to what participants preferred to tackle within the parameters we agreed on earlier.
We were also very glad have a co-founder of the Corda blockchain project hang out with us during our session and tell us a bit about this very interesting new system.

As we discussed in previous meetups, because payments are at the core of most blockchain services, we decided that an adequate first project would be a very simple full stack blockchain payment solution that has a user-friendly UI for all participants.
While payments may seem like a relatively trivial issue, there are many aspects to take into consideration.

How can the consumer trust the provider? 
What should be the process for small payments compared to large ones?
How can we accommodate payments that require regulatory compliance? 
How can we simplify the process?
.
.
.

So we tried to break down most of these scenarios in order to figure out what are the fundamental payment systems that we'd need to construct and they seemed to fall into three main categories in order to satisfy trust facilitation as well as legal compliance.
I'll break down the payment routes again since we've formulated and understood them much better at this stage and summarized them once again before getting down to code and design:

1. Consumer pays directly to provider.
This payment form has the main advantage of being as quick as the finality (TX confirmation time) of the hosting blockchain, but lacks any way of protecting the consumer in case of a post purchase dispute.
One way around this issue would be to require allow a service provider that wants to facilitate trust, to stake the amount of value that would be considered satisfactory to compensate consumers in case of a dispute but this is difficult to estimate and would need to be adjusted on a case by case basis.

2. Consumers funds are timelocked for an agreed upon period.
This would give both consumers and service providers the chance to create a claim that would automatically involve a trusted 3rd party that would settle the dispute either way. The main advantage of this method is that if no dispute arises, it is as cheap to utilize as sending a direct payment.
If sufficient value is staked, as discussed in the first payment method, then the payment can go through immediately and a dispute can still be issued by the consumer for a certain period of time (this period indicates the amount of value the provider needs to stake according to the volume of services they may provide during this period. Here we're getting into the logic of insurance and I will refer to it as that from here on).

3. Consumers funds are only processed with regulating party's consent.
Payments that always require regulatory compliance, such as real estate deals, require the consent of several parties before they should be finalized.
Lawyers, notaries, government offices and other participants, must approve the transfer of ownership of real estate properties. We can accommodate this by putting a 3rd party in charge of clearing the TX only once they verify that all the requirements, whatever they may be, have been satisfied. 

Being able to accommodate within the same platform such a broad set of TX's is powerful!
It basically means that we're creating a single platform that can process basic payments, as well as insured payments, and payments that require legal compliance.

After agreeing on all of this we set out to start building it.
We decided to split the teams into from and back end work.

The front-end team, led by Lucky, created the first drafts for the design of the payment app and they look excellent.
The front-end web UI was postponed until we figure out what elements we need to build.  
You can find them [here](https://github.com/RealizingBlockchain/Payment-Infrastructure/tree/master/frontend/mock-ups).

The back-end team, led by Dominik, decided that it's necessary to build first the smart contract in order to figure out how to construct the back end with the web3 elements that are needed to communicate with the Ethereum blockchain.
They ended up creating a skeleton contract that defined the functions and variables that the dApp would require to perform its task. Of course, this will change tremendously as we tackle solidity specifics as well as discover new efficient ways to perform our tasks as well as add all the extra features some of which I have discussed in later comments on the solidity code.
You can find the history of this file [here](https://github.com/RealizingBlockchain/Payment-Infrastructure/commits/master/backend/contracts/payments.sol).

Tomas Hanak who specializes in Java started to implement the web3j (Java based web3 library) that is required to communicate between the back end and the contract, and I was impressed how quickly he managed to put it together.
You can find that [here](https://github.com/RealizingBlockchain/Payment-Infrastructure/tree/master/backend/application-servers/payment-backend-java).

## 2018-09-15

Looking through our designs from Saturday 2018-09-1, we realized that the simple escrow project which is a great place to start, is actually part of a bigger picture.

- The little picture:

Currently we'd like to take on simple project with a clear use-case.
We agreed to create an escrow contract that routes a payment with an escrow that must intermediate in order for the payment to be processed in a trust-less manner.
While this may sound trivial, here are some features to consider in the front and back ends.

Back-end: 
If the escrow fails to authorize the payment? The payment should probably be reversible by the client after a certain number of blocks.

Users at this point use their own wallets and interact with digital money. We can, to reduce exposure to volatility, convert fiat somehow on both edges or charge an extra margin from the buyer to compensate for market fluctuations.
I know these are both ugly solutions, but while things are gradually getting better, that's the best we got my fellow blockchain devs 👍 

Front-end:

How do we implement that into the front end? Well, you know, it needs to be easy to use and pretty :D

- The bigger picture:
Depending on the type of transaction, the transacted amount, the provided service, legalities and the preferences of the interacting parties, we may want to use different payment models.
Either the user’s preference, type of service, size of TX, regulatory or logical requirements of a TX would indicate to the contract what route the money would take.
We would need to create a UI as well to give convenient access to all interacting parties, including but not limited to the: service provider, consumer, escrow and oversight parties.

Examples:
Buying coffee - uses direct payment without time lock or escrow functionality.

second hand car - uses agreed upon time lock duration that will only charge escrow services in-case a dispute is opened by one of the parties.

Real estate - uses escrow that verifies all legal obligations were met.




Model 1: Buying a cup of coffee. direct payment, no delay, no escrow, (most likely free service)
Low payment, 0 delay, no legal implication, low mistrust, no intervention dispute management, etc...
This is a very simple TX and is the most common type of payment. You basically pay for something small, and in case of a breach of trust, interacting parties can settle the dispute or involve the authorities to mediate.
Even if dispute settling fails, the amount lost is not significant enough to cause much harm to any of the parties.

We can also create a dispute settling mechanism where a sum is entrusted with the escrow in case of a post direct payment dispute.


Model 2: Buying a used car. Payment can have a time lock that both parties can agree on and settlement only goes to escrow in case a dispute is submitted by one of the interacting parties (could include the escrow). 

Model 3: Buying a house. Payment can only be processed once all legal and regulatory obligations are fulfilled and therefore must be authorized by the escrow.


Of course, some will insist that many of the escrow services can be automated.
We are open to that and would like to implement those features, but those features add an incredible amount of complexity that we can't overcome at this point. We want to keep it simple and we want to build something that someone can use, whether it's complete, partially flawed or not. 

We also prefer to KYC all service providers and consumers on our platform to create a trusted environment and to keep things simple for now.

- You can check out the material from two weeks ago where you'll find the plans for building this module.

## 2018-09-12

### Smart Contract Best Practices and Debugging with Dean Eigenmann

- We went over a (very!) flawed smart contract designed to teach smart contract security best practices and what not to do when building on top of Ethereum.
- All the materials from the evening can be found **[here](https://github.com/RealizingBlockchain/Zurich-Blockchain-Devs/tree/master/Smart-Contract-Best-Practices)**
- I've added some of our observations to the [Lottery Contract Problems](https://github.com/RealizingBlockchain/Zurich-Blockchain-Devs/tree/master/Smart-Contract-Best-Practices), please add more of yours if I've missed anything.


## 2018-09-01

What we talked about:
 
 - Gauging the state of the blockchain ecosystem by comparing it to the evolution of the modern computer.

We found that comparing the parts that make up a blockchain to the parts that make up our computers helps to understand where blockchains are headed, what advancements we should be on the lookout for, and what we should invest our energy into developing.

If this idea makes sense to you and you'd like to help develop it, you're most welcome to!

[Computers VS Blockchains - Repo] (https://github.com/RealizingBlockchain/Computers-VS-Blockchains/blob/master/README.md)

 - what we can achieve during our early meetup session (real estate/payment smart contract)

The idea of competing in blockchain related bounties and competitions is a very welcome idea by everyone as it helps to create momentum, practice, and unity where we need it most.
The only draw-back with competitions is that they are fairly complex, so we decided to chase smaller goals first, so we don't risk losing momentum in our group.
Our initial idea is to facilitate a C2B (client to business) transaction in the form of crypto for service while we act as the third party that insures there are no disputes by the end of the service.
You can find a flow chart below that describes the flow of an MVP (minimal viable product) although I'll try to expand on the flow chart to explain what UI's need to be developed and when notifications of advancement are invoked and received.
We basically want to put together all the parts that are needed to facilitate such a transaction gracefully and securely and we are completely open minded about how the process should be constructed and are currently tending towards incorporating an escrow, which we will be until the contract and UI is ready to be used by unrelated parties.
We would need to create the solidity contract, build a UI for it, deploy it and use it, not as simple as it sounds..

 - we discussed possibilities for a long-term plan of the meetup group (remote work, place where to meet etc.)

*We agreed that we would need to concentrate our effort and reduce energy losses in the overall structure of the group in order to be productive enough to survive the blockchain drought and even excel in it.

*We took a comparison from the Tesla car company that I like to make where unlike an internal combustion engine that produces plenty of heat waste, battery powered cars lose a lot of range when they need to keep the batteries and cabin warm in cold weather. To reduce these losses, Tesla cars try to capture as much waste heat off moving and static parts as possible.
At the end, we want to make sure that this group serves the people that join it and contribute to it, it is your group.

*We will establish a core team and work to incorporate our members into it.
This means that while the advanced and familiar group gets to focus on their work, joining members are helped by some of us to get up to speed so they can begin contributing to our development to the benefit of them and of all. (super poetic)

*We will also concentrate our efforts around GitHub, again, so we don't lose efficiency because of a lack of collaboration and communication outside of the meetup itself or with those that cannot attend our meetups. Everyone's welcome to contribute to our repository.

*It's really important that we keep both the Wednesday and Saturday groups in sync, so we don't lose energy there. 

 - how to be organized (Telegram "Zurich Blockchain Developers - Advanced", Slack, this GitHub)

We're looking for the best chat tool to communicate with about the development in the repo, and we're currently mainly contemplating between Discord (many awesome features) and Slack (Threads for each message + awesome features).
(Come on Discord, implement threads already, it's not proprietary and it will bring you a ton a business!), had to express my frustrations there.

 - We started to work on a Solidity smart contract to achieve payment transaction PoC for a Dentist who wants to accept crypto but used it mostly to teach solidity, so in-case you're looking for a correlation between the flow chart and smart contract and can't really find one, we need you in our group :)
We prepared basic requirements + started writing a code, testing with Remix and MetaMask.

 - Here is a flow diagram of the simple transaction project. Changes can be done if you follow this [link](https://drive.google.com/file/d/1l2aGwEq_ixEq7JXabvmqeMyfT6elwQeo/view?usp=sharing)

![simple transaction MVP](https://github.com/RealizingBlockchain/Zurich-meetup-solidity-examples/blob/master/simple%20blockchain%20transaction.jpg)

## 2018-08-18
What we did:
- coding session to onboard new members

## 2018-08-11
What we discussed:
- that we should tackle a smaller problem than real estate first to make it easier to learn while we are still gaining insights into the real estate ecosystem
- this smaller problem is: a smart contract that allows for a transaction between two parties, 
but with a trusted third party that verifies the identity of the parties 
and could step in as an arbitrator in case of disputes.

What we did:
- coding session: started with [TransactionWithThirdParty](https://github.com/RealizingBlockchain/another-repo1/blob/master/meetup_11_August_2018.sol)

## 2018-08-04
What we discussed:
- the idea of participating in the "Real Estate Blockchain Competition" as a group came up
- how we can "onboard" new group members while having a core-team that develops our ideas further by giving introductory coding sessions to new members in parallel.

What we did:
- our first small coding session
