Totes Random Bot
================
<a href='http://www.recurse.com' title='Made with love at the Recurse Center'><img src='https://cloud.githubusercontent.com/assets/2883345/11325206/336ea5f4-9150-11e5-9e90-d86ad31993d8.png' height='20px'/></a>

Taking [random numbers](http://www.totes-random.website/) that were [generated from Twitter](https://github.com/JKiely/Totes-Random), and posting them to [Twitter](https://twitter.com/totesRandom_bot), 140 bits at a time.

What?
-----
After me, [Sean](https://github.com/phasedchirp), and [Taylor](https://github.com/tayloraburgess) unleashed the potential of twitter for the purpose of generating random numbers, we knew that we had a valuable resource on our hands, a resource that had to be shared with the world. And what better way to share it than via Twitter? With this bot we not only make randomness easily accessible, but we deliver the wealth directly back in the hands of our laborers.

How?
----
Much like the original Totes Random, Totes Random Bot is written in Haskell using stack. It hits the `/bits` endpoint of the Totes Random api in order to get 140 random bits, and posts them to Twitter using the api. It then hits the `/float` endpoint to get a random float (n) between 0 and 1, and waits for (n * 24) hours before it tweets again. 


<img src="http://www.jkly.io/images/ouroboros.jpg">

<sub>Image credit goes to <a href=http://oglaf.com/>Oglaf (nsfw).</a> Buy the t-shirt from them at <a href="https://www.topatoco.com/merchant.mvc?Screen=PROD&Store_Code=TO&Product_Code=OG-OUROBOROS&Category_Code=OG">Topatoco.</a></sub>
