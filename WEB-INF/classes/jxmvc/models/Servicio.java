package jxmvc.models;

import jxmvc.base.AdminDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class Servicio {
    public int id;
    public String titulo;
    public String descripcion;
    public String imagenUrl;
    public int enlaceId;
    public String enlaceUrl;
    public String enlaceTexto;
    public boolean enlaceNuevaPestana;
    public int orden;
    public boolean activo;
    public Timestamp createdAt;

    static Servicio map(ResultSet rs) throws SQLException {
        Servicio s = new Servicio();
        s.id = rs.getInt("id");
        s.titulo = rs.getString("titulo");
        s.descripcion = rs.getString("descripcion");
        s.imagenUrl = rs.getString("imagen_url");
        s.enlaceId = rs.getInt("enlace_id");
        s.enlaceUrl = rs.getString("e_url");
        s.enlaceTexto = rs.getString("e_descripcion");
        s.enlaceNuevaPestana = rs.getBoolean("e_abrir_nueva_pestana");
        s.orden = rs.getInt("orden");
        s.activo = rs.getBoolean("activo");
        s.createdAt = rs.getTimestamp("created_at");
        return s;
    }

    private static final String SELECT_WITH_ENLACE =
        "SELECT t.*, e.url AS e_url, e.descripcion AS e_descripcion, " +
        "e.abrir_nueva_pestana AS e_abrir_nueva_pestana " +
        "FROM servicios t LEFT JOIN enlaces e ON t.enlace_id = e.id";

    public static List<Servicio> getActivas() {
        return AdminDB.queryList(
            SELECT_WITH_ENLACE + " WHERE t.activo = true ORDER BY t.orden",
            null, Servicio::map
        );
    }

    public static List<Servicio> getAll() {
        return AdminDB.queryList(
            SELECT_WITH_ENLACE + " ORDER BY t.orden",
            null, Servicio::map
        );
    }

    public static Servicio getById(int id) {
        return AdminDB.queryOne(
            SELECT_WITH_ENLACE + " WHERE t.id = ?",
            new Object[]{id}, Servicio::map
        );
    }

    public static int create(Servicio s) {
        return AdminDB.insertAndGetKey(
            "INSERT INTO servicios (titulo, descripcion, imagen_url, enlace_id, orden, activo) " +
            "VALUES (?, ?, ?, ?, ?, ?)",
            s.titulo, s.descripcion, s.imagenUrl, s.enlaceId > 0 ? s.enlaceId : null, s.orden, s.activo
        );
    }

    public static void update(Servicio s) {
        AdminDB.execute(
            "UPDATE servicios SET titulo=?, descripcion=?, imagen_url=?, enlace_id=?, " +
            "orden=?, activo=? WHERE id=?",
            s.titulo, s.descripcion, s.imagenUrl, s.enlaceId > 0 ? s.enlaceId : null, s.orden, s.activo, s.id
        );
    }

    public static void delete(int id) {
        AdminDB.execute("DELETE FROM servicios WHERE id = ?", id);
    }

    public static void reorder(List<Integer> idsInOrder) {
        for (int i = 0; i < idsInOrder.size(); i++) {
            AdminDB.execute(
                "UPDATE servicios SET orden = ? WHERE id = ?",
                i + 1, idsInOrder.get(i)
            );
        }
    }
}
