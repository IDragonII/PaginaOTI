package jxmvc.models;

import jxmvc.base.AdminDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class Actividad {
    public int id;
    public String titulo;
    public String tipo;
    public String descripcion;
    public String imagenUrl;
    public int enlaceId;
    public String enlaceUrl;
    public String enlaceTexto;
    public boolean enlaceNuevaPestana;
    public int orden;
    public boolean activo;
    public Timestamp createdAt;
    public Timestamp updatedAt;

    private static Actividad map(ResultSet rs) throws SQLException {
        Actividad a = new Actividad();
        a.id = rs.getInt("id");
        a.titulo = rs.getString("titulo");
        a.tipo = rs.getString("tipo");
        a.descripcion = rs.getString("descripcion");
        a.imagenUrl = rs.getString("imagen_url");
        a.enlaceId = rs.getInt("enlace_id");
        a.enlaceUrl = rs.getString("e_url");
        a.enlaceTexto = rs.getString("e_descripcion");
        a.enlaceNuevaPestana = rs.getBoolean("e_abrir_nueva_pestana");
        a.orden = rs.getInt("orden");
        a.activo = rs.getBoolean("activo");
        a.createdAt = rs.getTimestamp("created_at");
        a.updatedAt = rs.getTimestamp("updated_at");
        return a;
    }

    private static final String SELECT_WITH_ENLACE =
        "SELECT t.*, e.url AS e_url, e.descripcion AS e_descripcion, " +
        "e.abrir_nueva_pestana AS e_abrir_nueva_pestana " +
        "FROM actividades t LEFT JOIN enlaces e ON t.enlace_id = e.id";

    public static List<Actividad> getActivas() {
        return AdminDB.queryList(
            SELECT_WITH_ENLACE + " WHERE t.activo = true ORDER BY t.orden",
            null, Actividad::map
        );
    }

    public static List<Actividad> getAll() {
        return AdminDB.queryList(
            SELECT_WITH_ENLACE + " ORDER BY t.orden",
            null, Actividad::map
        );
    }

    public static Actividad getById(int id) {
        return AdminDB.queryOne(
            SELECT_WITH_ENLACE + " WHERE t.id = ?",
            new Object[]{id}, Actividad::map
        );
    }

    public static int create(Actividad a) {
        return AdminDB.insertAndGetKey(
            "INSERT INTO actividades (titulo, tipo, descripcion, imagen_url, enlace_id, orden, activo) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?)",
            a.titulo, a.tipo, a.descripcion, a.imagenUrl, a.enlaceId > 0 ? a.enlaceId : null, a.orden, a.activo
        );
    }

    public static void update(Actividad a) {
        AdminDB.execute(
            "UPDATE actividades SET titulo=?, tipo=?, descripcion=?, imagen_url=?, enlace_id=?, " +
            "orden=?, activo=?, updated_at=NOW() WHERE id=?",
            a.titulo, a.tipo, a.descripcion, a.imagenUrl, a.enlaceId > 0 ? a.enlaceId : null, a.orden, a.activo, a.id
        );
    }

    public static void delete(int id) {
        AdminDB.execute("DELETE FROM actividades WHERE id = ?", id);
    }

    public static void reorder(List<Integer> idsInOrder) {
        for (int i = 0; i < idsInOrder.size(); i++) {
            AdminDB.execute(
                "UPDATE actividades SET orden = ?, updated_at = NOW() WHERE id = ?",
                i + 1, idsInOrder.get(i)
            );
        }
    }

    public static void toggleActivo(int id, boolean activo) {
        AdminDB.execute(
            "UPDATE actividades SET activo = ?, updated_at = NOW() WHERE id = ?",
            activo, id
        );
    }
}
