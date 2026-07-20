package jxmvc.models;

import jxmvc.base.AdminDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

/**
 * Modelo para la plana directiva.
 */
public class PlanaDirectiva {
    public int id;
    public String nombre;
    public String cargo;
    public String descripcion;
    public String fotoUrl;
    public String linkedinUrl;
    public String twitterUrl;
    public int orden;
    public boolean activo;
    public Timestamp createdAt;

    // ── Row mapper ──────────────────────────────────────────────

    private static PlanaDirectiva map(ResultSet rs) throws SQLException {
        PlanaDirectiva p = new PlanaDirectiva();
        p.id = rs.getInt("id");
        p.nombre = rs.getString("nombre");
        p.cargo = rs.getString("cargo");
        p.descripcion = rs.getString("descripcion");
        p.fotoUrl = rs.getString("foto_url");
        p.linkedinUrl = rs.getString("linkedin_url");
        p.twitterUrl = rs.getString("twitter_url");
        p.orden = rs.getInt("orden");
        p.activo = rs.getBoolean("activo");
        p.createdAt = rs.getTimestamp("created_at");
        return p;
    }

    // ── Queries ─────────────────────────────────────────────────

    public static List<PlanaDirectiva> getActivos() {
        return AdminDB.queryList(
            "SELECT * FROM plana_directiva WHERE activo = true ORDER BY orden",
            null, PlanaDirectiva::map
        );
    }

    public static List<PlanaDirectiva> getAll() {
        return AdminDB.queryList(
            "SELECT * FROM plana_directiva ORDER BY orden",
            null, PlanaDirectiva::map
        );
    }

    public static PlanaDirectiva getById(int id) {
        return AdminDB.queryOne(
            "SELECT * FROM plana_directiva WHERE id = ?",
            new Object[]{id}, PlanaDirectiva::map
        );
    }

    // ── CRUD ────────────────────────────────────────────────────

    public static int create(PlanaDirectiva p) {
        return AdminDB.insertAndGetKey(
            "INSERT INTO plana_directiva (nombre, cargo, descripcion, foto_url, linkedin_url, twitter_url, orden, activo) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
            p.nombre, p.cargo, p.descripcion, p.fotoUrl, p.linkedinUrl, p.twitterUrl, p.orden, p.activo
        );
    }

    public static void update(PlanaDirectiva p) {
        AdminDB.execute(
            "UPDATE plana_directiva SET nombre=?, cargo=?, descripcion=?, foto_url=?, " +
            "linkedin_url=?, twitter_url=?, orden=?, activo=? WHERE id=?",
            p.nombre, p.cargo, p.descripcion, p.fotoUrl, p.linkedinUrl, p.twitterUrl, p.orden, p.activo, p.id
        );
    }

    public static void delete(int id) {
        AdminDB.execute("DELETE FROM plana_directiva WHERE id = ?", id);
    }

    public static void reorder(List<Integer> idsInOrder) {
        for (int i = 0; i < idsInOrder.size(); i++) {
            AdminDB.execute(
                "UPDATE plana_directiva SET orden = ? WHERE id = ?",
                i + 1, idsInOrder.get(i)
            );
        }
    }
}
