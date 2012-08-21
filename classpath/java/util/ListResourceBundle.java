package java.util;

public abstract class ListResourceBundle extends ResourceBundle {
    private Hashtable <String,Object> items = null;
    
    protected abstract Object[][] getContents();
    
    @Override
    protected Object handleGetObject(String string) {
        load();
        return items.get(string);
    }
    
    @Override
    public Enumeration<String> getKeys() {
        load();
        
        return items.keys();
    }
    
    
    private synchronized void load() {
        if(items==null) {
            Object[][] contents = getContents();
            Hashtable <String,Object> tmp = new Hashtable<String, Object>(contents.length);
            
            for(int i=0; i<contents.length; i++) {
                String key = (String)contents[i][0];
                Object value = contents[i][1];
                
                tmp.put(key, value);
            }
            
            items = tmp;
        }
    }
}

