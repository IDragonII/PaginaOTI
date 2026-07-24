package jxmvc.models;

import jxmvc.base.AdminDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class Documento {
    public int id;
    public String titulo;
    public String descripcion;
    public String url;
    public String archivoUrl;
    public String tipo;
    public int orden;
    public boolean activo;
    public Timestamp createdAt;

    private static Documento map(ResultSet rs) throws SQLException {
        Documento d = new Documento();
        d.id = rs.getInt("id");
        d.titulo = rs.getString("titulo");
        d.descripcion = rs.getString("descripcion");
        d.url = rs.getString("url");
        d.archivoUrl = rs.getString("archivo_url");
        d.tipo = rs.getString("tipo");
        d.orden = rs.getInt("orden");
        d.activo = rs.getBoolean("activo");
        d.createdAt = rs.getTimestamp("created_at");
        return d;
    }

    public static List<Documento> getActivos() {
        return AdminDB.queryList(
            "SELECT * FROM documentos WHERE activo = true ORDER BY orden",
            null, Documento::map
        );
    }

    public static List<Documento> getAll() {
        return AdminDB.queryList(
            "SELECT * FROM documentos ORDER BY orden",
            null, Documento::map
        );
    }

    public static Documento getById(int id) {
        return AdminDB.queryOne(
            "SELECT * FROM documentos WHERE id = ?",
            new Object[]{id}, Documento::map
        );
    }

    public static int create(Documento d) {
        return AdminDB.insertAndGetKey(
            "INSERT INTO documentos (titulo, descripcion, url, archivo_url, tipo, orden, activo) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?)",
            d.titulo, d.descripcion, d.url, d.archivoUrl, d.tipo, d.orden, d.activo
        );
    }

    public static void update(Documento d) {
        AdminDB.execute(
            "UPDATE documentos SET titulo=?, descripcion=?, url=?, archivo_url=?, " +
            "tipo=?, orden=?, activo=? WHERE id=?",
            d.titulo, d.descripcion, d.url, d.archivoUrl, d.tipo, d.orden, d.activo, d.id
        );
    }

    public static void delete(int id) {
        AdminDB.execute("DELETE FROM documentos WHERE id = ?", id);
    }

    public static void reorder(List<Integer> idsInOrder) {
        for (int i = 0; i < idsInOrder.size(); i++) {
            AdminDB.execute(
                "UPDATE documentos SET orden = ? WHERE id = ?",
                i + 1, idsInOrder.get(i)
            );
        }
    }
}
