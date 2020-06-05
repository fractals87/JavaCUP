package cup.tools;

public class Lib {

	public static boolean compatibleType(TypeDescriptor td1, TypeDescriptor td2){
        if(td1 != TypeDescriptor.ERROR && td2 != TypeDescriptor.ERROR && td1 == td2 ){
            return true;
        }
        if(td1 == TypeDescriptor.FLOAT && td2 == TypeDescriptor.INT){
            return true;
        }
        return false;
    }

}
