package java.security;

public interface PrivilegedExceptionAction {
    public Object run() throws PrivilegedActionException;
}