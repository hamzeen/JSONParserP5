/**
 * An example for JsonParserP5
 * @author: hamzeen. h.
 * @created 04/03/2013
 */
import com.hamzeen.json.JsonParserP5;
import org.json.JSONArray;

String[] tweets;String[] repos;
JsonParserP5 jsonParser;
PFont font;

void setup(){
  size(790,350);
  background(0);
  smooth();
  font = loadFont("ARJULIAN-48.vlw");
  jsonParser = JsonParserP5.getSingelton();
  JSONArray tweetObjs = jsonParser.parseJson("https://api.twitter.com/1/statuses/user_timeline/TwitterOSS.json?count=2&include_rts=1");
  JSONArray githubObjs = jsonParser.parseJson("https://api.github.com/users/processing/repos");
  
  tweets = new String[tweetObjs.length()];
  for(int i=0;i<tweets.length;i++){
    tweets[i] = (String)tweetObjs.getJSONObject(i).get("text");
  }
  
  repos = new String[githubObjs.length()];
  for(int i=0;i<repos.length;i++){
    repos[i] = (String)githubObjs.getJSONObject(i).get("name");
  }
}

String splitByWordAt(final int count,String tweet){
  StringBuilder builder = new StringBuilder();
  String[] words = tweet.split("\\s+");
  for(int i=0;i<words.length;i++){
    if(i%count==0){
      if(i==0){
        builder.append(words[i]);
      }else{
        builder.append("\n"+words[i]);
      }
    } else{
        builder.append(" "+words[i]);
    }
  }
  return new String(builder.toString());
}

void draw(){
  noStroke();
  textFont(font,20);

  fill(255,255,0);
  text("Tweets from OpenSource Twitter: ",40,40);

  fill(225,225,225);
  for(int i=0;i<tweets.length;i++){
    text(splitByWordAt(10,tweets[i]),24,80+i*66);
  }

  fill(255,255,0);
  text("Processing repos on Github: ",40,230);
  
  fill(225,225,225);
  for(int i=0;i<repos.length;i++){
    text(repos[i],24,260+i*22);
  }
}

