package jxmvc.models;

import jxmvc.base.AdminDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class Enlace {
    public int id;
    public String titulo;
    public String url;
    public String descripcion;
    public boolean abrirNuevaPestana;
    public boolean activo;
    public Timestamp createdAt;
    public Timestamp updatedAt;

    static Enlace map(ResultSet rs) throws SQLException {
        Enlace e = new Enlace();
        e.id = rs.getInt("id");
        e.titulo = rs.getString("titulo");
        e.url = rs.getString("url");
        e.descripcion = rs.getString("descripcion");
        e.abrirNuevaPestana = rs.getBoolean("abrir_nueva_pestana");
        e.activo = rs.getBoolean("activo");
        e.createdAt = rs.getTimestamp("created_at");
        e.updatedAt = rs.getTimestamp("updated_at");
        return e;
    }

    public static Enlace getById(int id) {
        return AdminDB.queryOne(
            "SELECT * FROM enlaces WHERE id = ?",
            new Object[]{id}, Enlace::map
        );
    }

    public static int create(Enlace e) {
        return AdminDB.insertAndGetKey(
            "INSERT INTO enlaces (titulo, url, descripcion, abrir_nueva_pestana, activo) " +
            "VALUES (?, ?, ?, ?, ?)",
            e.titulo, e.url, e.descripcion, e.abrirNuevaPestana, e.activo
        );
    }

    public static void update(Enlace e) {
        AdminDB.execute(
            "UPDATE enlaces SET titulo=?, url=?, descripcion=?, abrir_nueva_pestana=?, " +
            "activo=?, updated_at=NOW() WHERE id=?",
            e.titulo, e.url, e.descripcion, e.abrirNuevaPestana, e.activo, e.id
        );
    }

    public static void delete(int id) {
        AdminDB.execute("DELETE FROM enlaces WHERE id = ?", id);
    }

    public static List<Enlace> getAll() {
        return AdminDB.queryList(
            "SELECT * FROM enlaces ORDER BY id",
            null, Enlace::map
        );
    }
}
