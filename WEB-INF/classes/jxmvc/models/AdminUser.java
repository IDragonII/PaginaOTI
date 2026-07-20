package jxmvc.models;

import jxmvc.base.AdminDB;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

/**
 * Modelo para usuarios admin.
 */
public class AdminUser {
    public int id;
    public String username;
    public String passwordHash;
    public String nombre;
    public String email;
    public String rol;       // 'superadmin', 'editor'
    public boolean activo;
    public Timestamp createdAt;

    // ── Row mapper ──────────────────────────────────────────────

    private static AdminUser map(ResultSet rs) throws SQLException {
        AdminUser u = new AdminUser();
        u.id = rs.getInt("id");
        u.username = rs.getString("username");
        u.passwordHash = rs.getString("password_hash");
        u.nombre = rs.getString("nombre");
        u.email = rs.getString("email");
        u.rol = rs.getString("rol");
        u.activo = rs.getBoolean("activo");
        u.createdAt = rs.getTimestamp("created_at");
        return u;
    }

    // ── Queries ─────────────────────────────────────────────────

    public static AdminUser getByUsername(String username) {
        return AdminDB.queryOne(
            "SELECT * FROM admin_users WHERE username = ? AND activo = true",
            new Object[]{username}, AdminUser::map
        );
    }

    public static AdminUser getById(int id) {
        return AdminDB.queryOne(
            "SELECT * FROM admin_users WHERE id = ?",
            new Object[]{id}, AdminUser::map
        );
    }

    public static List<AdminUser> getAll() {
        return AdminDB.queryList(
            "SELECT * FROM admin_users ORDER BY id",
            null, AdminUser::map
        );
    }

    // ── CRUD ────────────────────────────────────────────────────

    public static int create(AdminUser u) {
        return AdminDB.insertAndGetKey(
            "INSERT INTO admin_users (username, password_hash, nombre, email, rol, activo) " +
            "VALUES (?, ?, ?, ?, ?, ?)",
            u.username, u.passwordHash, u.nombre, u.email, u.rol, u.activo
        );
    }

    public static void update(AdminUser u) {
        AdminDB.execute(
            "UPDATE admin_users SET nombre=?, email=?, rol=?, activo=? WHERE id=?",
            u.nombre, u.email, u.rol, u.activo, u.id
        );
    }

    public static void updatePassword(int id, String newHash) {
        AdminDB.execute(
            "UPDATE admin_users SET password_hash = ? WHERE id = ?",
            newHash, id
        );
    }

    public static void delete(int id) {
        AdminDB.execute("DELETE FROM admin_users WHERE id = ?", id);
    }

    // ── Helpers ─────────────────────────────────────────────────

    public boolean isSuperadmin() {
        return "superadmin".equals(rol);
    }

    /**
     * Verifica password usando BCrypt.
     */
    public boolean checkPassword(String rawPassword) {
        try {
            return BCrypt.checkpw(rawPassword, this.passwordHash);
        } catch (IllegalArgumentException e) {
            return false;
        }
    }
}
