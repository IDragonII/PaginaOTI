package jxmvc.models;

import jxmvc.base.AdminDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class Unidad {
    public int id;
    public String titulo;
    public String descripcion;
    public int enlaceId;
    public String enlaceUrl;
    public String enlaceTexto;
    public boolean enlaceNuevaPestana;
    public int orden;
    public boolean activo;
    public Timestamp createdAt;

    static Unidad map(ResultSet rs) throws SQLException {
        Unidad u = new Unidad();
        u.id = rs.getInt("id");
        u.titulo = rs.getString("titulo");
        u.descripcion = rs.getString("descripcion");
        u.enlaceId = rs.getInt("enlace_id");
        u.enlaceUrl = rs.getString("e_url");
        u.enlaceTexto = rs.getString("e_descripcion");
        u.enlaceNuevaPestana = rs.getBoolean("e_abrir_nueva_pestana");
        u.orden = rs.getInt("orden");
        u.activo = rs.getBoolean("activo");
        u.createdAt = rs.getTimestamp("created_at");
        return u;
    }

    private static final String SELECT_WITH_ENLACE =
        "SELECT t.*, e.url AS e_url, e.descripcion AS e_descripcion, " +
        "e.abrir_nueva_pestana AS e_abrir_nueva_pestana " +
        "FROM unidades t LEFT JOIN enlaces e ON t.enlace_id = e.id";

    public static List<Unidad> getActivas() {
        return AdminDB.queryList(
            SELECT_WITH_ENLACE + " WHERE t.activo = true ORDER BY t.orden",
            null, Unidad::map
        );
    }

    public static List<Unidad> getAll() {
        return AdminDB.queryList(
            SELECT_WITH_ENLACE + " ORDER BY t.orden",
            null, Unidad::map
        );
    }

    public static Unidad getById(int id) {
        return AdminDB.queryOne(
            SELECT_WITH_ENLACE + " WHERE t.id = ?",
            new Object[]{id}, Unidad::map
        );
    }

    public static int create(Unidad u) {
        return AdminDB.insertAndGetKey(
            "INSERT INTO unidades (titulo, descripcion, enlace_id, orden, activo) " +
            "VALUES (?, ?, ?, ?, ?)",
            u.titulo, u.descripcion, u.enlaceId > 0 ? u.enlaceId : null, u.orden, u.activo
        );
    }

    public static void update(Unidad u) {
        AdminDB.execute(
            "UPDATE unidades SET titulo=?, descripcion=?, enlace_id=?, " +
            "orden=?, activo=? WHERE id=?",
            u.titulo, u.descripcion, u.enlaceId > 0 ? u.enlaceId : null, u.orden, u.activo, u.id
        );
    }

    public static void delete(int id) {
        AdminDB.execute("DELETE FROM unidades WHERE id = ?", id);
    }

    public static void reorder(List<Integer> idsInOrder) {
        for (int i = 0; i < idsInOrder.size(); i++) {
            AdminDB.execute(
                "UPDATE unidades SET orden = ? WHERE id = ?",
                i + 1, idsInOrder.get(i)
            );
        }
    }
}
