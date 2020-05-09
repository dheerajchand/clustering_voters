# Using Clustering To Find Distressed People

## Credits

Enormous credit is due to [New Virginia Majority](https://www.newvirginiamajority.org) for donating the data used in this project. 
Thank you to Jamaa Bickley-King for consistently believing in us and hiring us to do cool things.

Many thanks to Julie Goldberg at [Empower Engine](https://www.empowerengine.com) for organizing the panel and giving us an opportunity to spread some ideas.

Thanks to [Dan Baston](http://www.danbaston.com/posts/2016/06/02/dbscan-clustering-in-postgis.html) for making a simple tutorial.

## What are we doing?

# What is a cluster?

A cluster is a subset of a set of observations that have something in common. 

Put another way, a cluster is the groups your data that are more similar to each other than all others with respect to some things.

Made even more simple, clusters are things that are more alike than not, natural organisations of things.

Spatially, we can specify target criteria, in this case, black people over the age of fifty, and ask the database to find chunks of space in which those people exist, coding them as such.
 
# Application 

It's an old saw that things that are closer together are more similar than those further away, and when it comes to finding people,
the entire premise of districts and areas is that people who live together are likely to have things in common. 

In this case, we're looking for chunks of space in which you there are groupings of people who are likely to be left behind an in need of aid.

To make things simple, we're going to assume that because of racism made law, middle aged black people in Virginia are more likely to need help than not.

# Code

- /inputs gives you a sense of what you will need to do this, which are boundaries from the Census.
    - There are two scripts, `fetch_census.sh` & `load_psql.sh`
    - Edit the former to only get the boundaries you want.
    - Edit the latter to set your PSQL permissions and it will load the shapefiles you downloaded.
    - This is probably a good place to store your VAN export formatted CSV/TSV/whatever.
    
- jamaa_clusterings.sql is a very simplified SQL file that shows you what you need to do with your voters table and Census shapefiles to get clusters.
    - Because the geocodes on your file are likely to be garbage, you will need to ensure that the geocodes are actually in the right boundaries.
    - That's what all the shapefiles you downloaded are for.
    
# Next steps 

You can make this really valuable by doing some [boundary estimation](https://www.siegeanalytics.com/features/boundary-estimation/) to turn your clusters into polygons.
 
 Once you have polygons, you can start analyzing how they relate to precincts, turf, etc. 
 
 Enjoy!
 
