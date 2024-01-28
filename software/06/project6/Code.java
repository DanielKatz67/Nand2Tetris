public class Code {
    /**
     *Returns the binary code of the dest (3 bits as a String)
     */
    public static String dest(String dest){
        if(dest == null)        return "000";
        if(dest.equals("M") )   return "001";
        if(dest.equals("D") )   return "010";
        if(dest.equals("DM") || dest.equals("MD"))  return "011";
        if(dest.equals("A") )   return "100";
        if(dest.equals("AM") || dest.equals("MA"))  return "101";
        if(dest.equals("AD") )  return "110";
        if(dest.equals("ADM") ) return "111";
        return null;
    }

    /**
     *Returns the binary code of the comp (7 bits as a String)
     */
    public static String comp(String comp){
        if(comp.equals("0"))                         return "101010";
        if(comp.equals("1"))                         return "111111";
        if(comp.equals("-1"))                        return "111010";
        if(comp.equals("D"))                         return "001100";
        if(comp.equals("A")  || comp.equals("M"))    return "110000";
        if(comp.equals("!D"))                        return "001101";
        if(comp.equals("!A") || comp.equals("!M"))   return "110001";
        if(comp.equals("-D"))                        return "001111";
        if(comp.equals("-A") || comp.equals("-M"))   return "110011";
        if(comp.equals("D+1"))                       return "011111";
        if(comp.equals("A+1") || comp.equals("M+1")) return "110111";
        if(comp.equals("D-1"))                       return "001110";
        if(comp.equals("A-1") || comp.equals("M-1")) return "110010";
        if(comp.equals("D+A") || comp.equals("D+M")) return "000010";
        if(comp.equals("D-A") || comp.equals("D-M")) return "010011";
        if(comp.equals("A-D") || comp.equals("M-D")) return "000111";
        if(comp.equals("D&A") || comp.equals("D&M")) return "000000";
        if(comp.equals("D|A") || comp.equals("D|M")) return "010101";
        return null;
    }

    /**
     *Returns the binary code of the jump (3 bits as a String)
     */
    public static String jump(String jump){
        if(jump == null)        return "000";
        if(jump.equals("JGT") ) return "001";
        if(jump.equals("JEQ") ) return "010";
        if(jump.equals("JGE") ) return "011";
        if(jump.equals("JLT") ) return "100";
        if(jump.equals("JNE") ) return "101";
        if(jump.equals("JLE") ) return "110";
        if(jump.equals("JMP") ) return "111";
        return null;
    }
}
