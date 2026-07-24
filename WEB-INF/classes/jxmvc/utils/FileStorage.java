package jxmvc.utils;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.util.UUID;

public class FileStorage {

    private static final String BASE_PATH = System.getProperty("catalina.home") + "/webapps/ROOT/assets/img";
    private static final long MAX_SIZE = 5 * 1024 * 1024;
    private static final String[] ALLOWED_TYPES = {"image/jpeg", "image/png", "image/webp", "image/gif"};
    private static final long MAX_INSTALLER_SIZE = 200 * 1024 * 1024;
    private static final String[] ALLOWED_INSTALLER_EXT = {"exe", "msi", "sh", "tar", "gz", "tar.gz", "dmg", "zip", "deb", "rpm", "appimage", "pkg"};
    private static final long MAX_DOC_SIZE = 10 * 1024 * 1024;
    private static final String[] ALLOWED_DOC_EXT = {"pdf"};

    public static String saveImage(Part part, String subfolder) throws IOException {
        if (part == null || part.getSize() == 0) return null;
        if (!isValidImage(part)) return null;

        String ext = getExtension(part.getSubmittedFileName());
        if (ext == null) ext = "jpg";

        String dirPath = BASE_PATH + File.separator + subfolder;
        Files.createDirectories(Paths.get(dirPath));

        String filename = UUID.randomUUID().toString() + "." + ext;
        String fullPath = dirPath + File.separator + filename;
        part.write(fullPath);

        return "/assets/img/" + subfolder + "/" + filename;
    }

    public static void deleteImage(String imageUrl) {
        if (imageUrl == null || imageUrl.isEmpty()) return;
        if (!imageUrl.startsWith("/assets/img/")) return;

        String fullPath = BASE_PATH + imageUrl.substring("/assets/img".length());
        File file = new File(fullPath);
        if (file.exists()) {
            file.delete();
        }
    }

    public static String saveFile(Part part, String subfolder) throws IOException {
        if (part == null || part.getSize() == 0) return null;
        if (!isValidInstaller(part)) return null;

        String original = part.getSubmittedFileName();
        String ext = getInstallerExtension(original);
        if (ext == null) ext = "bin";

        String dirPath = BASE_PATH + File.separator + subfolder;
        Files.createDirectories(Paths.get(dirPath));

        String filename = UUID.randomUUID().toString() + "." + ext;
        String fullPath = dirPath + File.separator + filename;
        part.write(fullPath);

        return "/assets/img/" + subfolder + "/" + filename;
    }

    public static void deleteFile(String fileUrl) {
        deleteImage(fileUrl);
    }

    public static boolean isValidInstaller(Part part) {
        if (part.getSize() > MAX_INSTALLER_SIZE) return false;
        String ext = getInstallerExtension(part.getSubmittedFileName());
        if (ext == null) return false;
        for (String allowed : ALLOWED_INSTALLER_EXT) {
            if (allowed.equals(ext)) return true;
        }
        return false;
    }

    private static String getInstallerExtension(String filename) {
        if (filename == null) return null;
        String lower = filename.toLowerCase();
        if (lower.endsWith(".tar.gz")) return "tar.gz";
        int dot = lower.lastIndexOf('.');
        if (dot < 0) return null;
        return lower.substring(dot + 1);
    }

    public static boolean isValidImage(Part part) {
        if (part.getSize() > MAX_SIZE) return false;
        String type = part.getContentType();
        if (type == null) return false;
        for (String allowed : ALLOWED_TYPES) {
            if (allowed.equals(type)) return true;
        }
        return false;
    }

    public static String saveDoc(Part part, String subfolder) throws IOException {
        if (part == null || part.getSize() == 0) return null;
        if (!isValidDoc(part)) return null;

        String ext = getExtension(part.getSubmittedFileName());
        if (ext == null) ext = "pdf";

        String dirPath = BASE_PATH + File.separator + subfolder;
        Files.createDirectories(Paths.get(dirPath));

        String filename = UUID.randomUUID().toString() + "." + ext;
        String fullPath = dirPath + File.separator + filename;
        part.write(fullPath);

        return "/assets/img/" + subfolder + "/" + filename;
    }

    public static boolean isValidDoc(Part part) {
        if (part.getSize() > MAX_DOC_SIZE) return false;
        String ext = getExtension(part.getSubmittedFileName());
        if (ext == null) return false;
        for (String allowed : ALLOWED_DOC_EXT) {
            if (allowed.equals(ext)) return true;
        }
        return false;
    }

    private static String getExtension(String filename) {
        if (filename == null) return null;
        int dot = filename.lastIndexOf('.');
        if (dot < 0) return null;
        return filename.substring(dot + 1).toLowerCase();
    }
}
