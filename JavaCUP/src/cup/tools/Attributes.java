package cup.tools;

/*
import ast.TypeDescriptor;
import exception.RegisterException;
*/
public class Attributes {
    private TypeDescriptor type;
    private String value;
    private static char[] regList = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
    private static int regIndex = 0;
    private char reg;
    
    public Attributes(String value, TypeDescriptor type) {
    	this(type);
    	this.value = value;
    }

    public Attributes(TypeDescriptor type) {
		super();
		this.type = type;
	}


	public void setType(TypeDescriptor type) {
		this.type = type;
	}

	public TypeDescriptor getType() {
        return type;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public char getReg() {
		return reg;
	}

	public void setReg() throws RegisterException {
		reg = newRegister();
		//System.out.println("SET_REG : " + reg);
	}
	
    public static char newRegister() throws RegisterException {
        if(regIndex > 25){
            throw new RegisterException("Not avaible register");
        }
        return regList[regIndex++];
    }
    
	@Override
    public String toString(){
        return "Att { " + type.toString() + " reg: " + reg + " }";
    }
}