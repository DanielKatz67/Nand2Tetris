import java.util.TreeMap;

public class SymbolTable {
    TreeMap<String,Integer> table ;
    int newAddress;


    /**
     *Creates new empty symbol table.
     */
    public SymbolTable (){
        table = new TreeMap<>();
        // enter the predefined symbols
        for (int i = 0; i < 16; i++) {
            table.put("R"+i, i);
        }
        table.put("SCREEN", 16384);
        table.put("KBD", 24576);
        table.put("SP", 0);
        table.put("LCL",1);
        table.put("ARG",2);
        table.put("THIS",3);
        table.put("THAT",4);
        // each variable is bound to a running memory address starting at 16;
        newAddress=16;
    }

    /**
     *Adds <symbol, address> to the table.
     */
    public void addEntry(String symbol, int address){
        table.put(symbol, address);
    }

    /**
     *Does the symbol table contain the given symbol?
     */
    public boolean contains(String symbol){
        return table.containsKey(symbol);
    }

    /**
     *Returns the address associated with the symbol.
     */
    public int getAddress(String symbol){
        return table.get(symbol);
    }
}
