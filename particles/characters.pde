import java.util.ArrayList;
import java.util.HashMap;


static class CharacterRepresentation { // FIXME(m-jeu): Consider making non-static and initing when constructor is called?
  // Contains (relative) coordinates as PVectors for characters as several simple dots
  static HashMap<Character, ArrayList<PVector>> coordinates = new HashMap<Character, ArrayList<PVector>>();
  
  /* Fill the coordinates attribute with content.
  Currently hardcoded and horribly inefficient.
  TODO(m-jeu): replace with read from JSON-file? 
  
  Lines should be drawn between pixels that are within dist 60?*/
  static void initCoordinates(){
    // Capital S
    ArrayList<PVector> sValue = new ArrayList<PVector>();
    sValue.add(new PVector(0, 0));
    
    sValue.add(new PVector(-60, -100));
    sValue.add(new PVector(0, -140));
    sValue.add(new PVector(100, -100));
    
    sValue.add(new PVector(60, 100));
    sValue.add(new PVector(0, 140));
    sValue.add(new PVector(-100, 100));
    
    CharacterRepresentation.coordinates.put(Character.valueOf('S'), sValue);
    
    //delta
    ArrayList<PVector> dValue = new ArrayList<PVector>();
    dValue.add(new PVector(0, -60));
    dValue.add(new PVector(42.42, 42.42));
    dValue.add(new PVector(-42.42, 42.42));
    
    CharacterRepresentation.coordinates.put(Character.valueOf('d'), dValue);
  }
  
  /** Get the coordinates of the representation of a certain character */
  static ArrayList<PVector> getRepr(Character c){
    return CharacterRepresentation.coordinates.get(c);
  }
  
  // Get the coordinates of the representation of a certain character, centered on a certain location */
  static ArrayList<PVector> getRepr(Character c, PVector relLocation){
    ArrayList<PVector> result = CharacterRepresentation.getRepr(c);
    for(PVector loc: result){
      loc.add(relLocation);
    }
    return result;
  }
}
