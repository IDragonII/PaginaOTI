package jxmvc.models;

import jxmvc.base.AdminDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

/**
 * Modelo para configuración general (key-value).
 */
public class Configuracion {
    public String clave;
    public String valor;
    public String tipo;
    public String descripcion;
    public Timestamp updatedAt;

    // ── Row mapper ──────────────────────────────────────────────

    private static Configuracion map(ResultSet rs) throws SQLException {
        Configuracion c = new Configuracion();
        c.clave = rs.getString("clave");
        c.valor = rs.getString("valor");
        c.tipo = rs.getString("tipo");
        c.descripcion = rs.getString("descripcion");
        c.updatedAt = rs.getTimestamp("updated_at");
        return c;
    }

    // ── Queries ─────────────────────────────────────────────────

    public static List<Configuracion> getAll() {
        return AdminDB.queryList(
            "SELECT * FROM configuracion ORDER BY clave",
            null, Configuracion::map
        );
    }

    public static Configuracion get(String clave) {
        return AdminDB.queryOne(
            "SELECT * FROM configuracion WHERE clave = ?",
            new Object[]{clave}, Configuracion::map
        );
    }

    /**
     * Obtiene el valor de una clave, o retorna default si no existe.
     */
    public static String getValue(String clave, String defaultValue) {
        Configuracion c = get(clave);
        return (c != null && c.valor != null && !c.valor.isEmpty()) ? c.valor : defaultValue;
    }

    /**
     * Obtiene el valor booleano de una clave.
     */
    public static boolean getBoolean(String clave, boolean defaultValue) {
        String val = getValue(clave, String.valueOf(defaultValue));
        return "true".equalsIgnoreCase(val) || "1".equals(val);
    }

    // ── CRUD ────────────────────────────────────────────────────

    public static void set(String clave, String valor, String tipo, String descripcion) {
        AdminDB.execute(
            "INSERT INTO configuracion (clave, valor, tipo, descripcion, updated_at) " +
            "VALUES (?, ?, ?, ?, NOW()) " +
            "ON CONFLICT (clave) DO UPDATE SET valor = EXCLUDED.valor, updated_at = NOW()",
            clave, valor, tipo, descripcion
        );
    }

    public static void update(String clave, String valor) {
        AdminDB.execute(
            "INSERT INTO configuracion (clave, valor, updated_at) VALUES (?, ?, NOW()) " +
            "ON CONFLICT (clave) DO UPDATE SET valor = EXCLUDED.valor, updated_at = NOW()",
            clave, valor
        );
    }

    public static void delete(String clave) {
        AdminDB.execute("DELETE FROM configuracion WHERE clave = ?", clave);
    }
}
