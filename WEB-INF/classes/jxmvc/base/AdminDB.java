package jxmvc.base;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Wrapper para conexión a la BD Admin (oti_admin).
 * Usa JNDI DataSource configurado en context.xml.
 */
public class AdminDB {
    private static DataSource ds;

    static {
        try {
            InitialContext ctx = new InitialContext();
            ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OtiAdminDB");
        } catch (Exception e) {
            throw new RuntimeException("AdminDB DataSource init failed", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return ds.getConnection();
    }

    // ── Query helper ─────────────────────────────────────────────

    @FunctionalInterface
    public interface RowMapper<T> {
        T map(ResultSet rs) throws SQLException;
    }

    public static <T> T queryOne(String sql, Object[] params, RowMapper<T> mapper) {
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            setParams(ps, params);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapper.map(rs);
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static <T> List<T> queryList(String sql, Object[] params, RowMapper<T> mapper) {
        List<T> list = new ArrayList<>();
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            setParams(ps, params);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapper.map(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public static int execute(String sql, Object... params) {
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            setParams(ps, params);
            return ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * INSERT y retorna generated key.
     */
    public static int insertAndGetKey(String sql, Object... params) {
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            setParams(ps, params);
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
                return -1;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private static void setParams(PreparedStatement ps, Object[] params) throws SQLException {
        if (params == null) return;
        for (int i = 0; i < params.length; i++) {
            ps.setObject(i + 1, params[i]);
        }
    }
}
