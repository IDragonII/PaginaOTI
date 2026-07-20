<%-- 
    Document   : layTicket
    Created on : May 23, 2025, 12:30:01 PM
    Author     : pietro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <style>
        .upload-container {
            position: relative;
            margin: 20px 0;
        }
        
        .upload-area {
            border: 2px dashed #6c757d;
            border-radius: 8px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s;
            background-color: #f8f9fa;
            cursor: pointer;
        }
        
        .upload-area:hover {
            border-color: #0d6efd;
            background-color: #e9f0ff;
        }
        
        .upload-area h5 {
            color: #495057;
        }
        
        .upload-area p {
            color: #6c757d;
            margin-bottom: 0;
        }
        
        #fileInput {
            display: none;
        }
        
        .file-info {
            margin-top: 20px;
            padding: 15px;
            border-radius: 8px;
            background-color: #e9ecef;
            display: none;
        }
        
        .file-info.active {
            display: block;
            animation: fadeIn 0.5s;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .file-icon {
            font-size: 24px;
            margin-right: 10px;
            color: #0d6efd;
        }
    </style>

<div>
    <h1> Ticket de Soporte y Mantenimiento </h1>
</div>
<hr>

<!-- Horario -->
<div class="alert alert-info mb-4">
    <b>Horario de atención:</b> Lunes a viernes 08:00am a 12:00pm
</div>

<div class="row">
    <div class="col-md-5">
        <form>
            <div class="mb-3">
                <label class="form-label"> Oficina </label>
                <input type="text" class="form-control w-100" id="ofi" placeholder="Ejm: Subunidad de trámite documentario">
            </div>
            <div class="mb-3">
                <label class="form-label"> Solicitante </label>
                <input type="text" class="form-control w-100" id="sol" placeholder="Ejm: Lic. Jose Rivera">
            </div>
            <div class="mb-3">
                <label class="form-label"> Dificultad encontrada </label>
                <select id="cbo" class="form-select" required>
                    <option value="" disabled selected> Seleccione </option>
                    <option value="1"> Mi PC no enciende </option>
                    <option value="2"> No hay internet en la oficina </option>
                    <option value="3"> Otros </option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label"> Mensaje </label>
                <textarea class="form-control w-100" id="msg" rows="3"></textarea>
            </div>
            <div class="mb-3">
                <button type="button" class="btn btn-primary w-100" onclick="doMsg()"> Enviar </button>
            </div>
        </form>
    </div>
    <div class="col-md-7">
        <h4 class="text-center mb-4">Ajuntar documento</h4>

        <div class="upload-container">
            <div class="upload-area" id="uploadArea">
                <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#6c757d" stroke-width="2" style="margin-bottom: 15px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" y1="3" x2="12" y2="15"></line></svg>
                <h5>Arrastra y suelta archivos aquí</h5>
                <p> En formato PDF </p>
            </div>
            <input type="file" id="fileInput">
            <div class="file-info" id="fileInfo">
                <div class="d-flex align-items-center">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#0d6efd" stroke-width="2" style="margin-right: 10px;"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                    <div>
                        <h6 class="mb-1" id="fileName">Nombre del archivo</h6>
                        <div class="d-flex">
                            <small class="text-muted me-3" id="fileSize">Tamaño: 0 KB</small>
                            <small class="text-muted" id="fileType">Tipo: Desconocido</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="d-grid gap-2 mt-3">
            <button type="button" class="btn btn-outline-primary" id="uploadBtn" onclick="document.getElementById('fileInput').click();">
                Subir Archivo
            </button>
        </div>
    </div>
</div>

<script>
function IsMobile()
{
    return /mobile|android|iphone|ipad|windows phone|opera mini|iemobile/i.test(navigator.userAgent);
}
    
function doMsg()
{          
    var btn = document.createElement("A");
    var dev = IsMobile()? "api" : "web";
    
    btn.href = "https://"+dev+".whatsapp.com/send?phone=51930654095&text=*Ticket OTI:* " + sol.value + " de *" +ofi.value+ "*, requiero: " + msg.value;
    btn.click();
}

// File Upload
(function() {
    var uploadArea = document.getElementById('uploadArea');
    var fileInput = document.getElementById('fileInput');
    var fileInfo = document.getElementById('fileInfo');
    var uploadBtn = document.getElementById('uploadBtn');

    if (!uploadArea || !fileInput) return;

    uploadArea.addEventListener('click', function() { fileInput.click(); });

    uploadArea.addEventListener('dragover', function(e) {
        e.preventDefault();
        uploadArea.style.borderColor = '#0d6efd';
        uploadArea.style.backgroundColor = '#e9f0ff';
    });

    uploadArea.addEventListener('dragleave', function() {
        uploadArea.style.borderColor = '#6c757d';
        uploadArea.style.backgroundColor = '#f8f9fa';
    });

    uploadArea.addEventListener('drop', function(e) {
        e.preventDefault();
        uploadArea.style.borderColor = '#6c757d';
        uploadArea.style.backgroundColor = '#f8f9fa';
        if (e.dataTransfer.files.length) {
            fileInput.files = e.dataTransfer.files;
            showFileInfo(e.dataTransfer.files[0]);
        }
    });

    fileInput.addEventListener('change', function() {
        if (fileInput.files.length) {
            showFileInfo(fileInput.files[0]);
        }
    });

    function showFileInfo(file) {
        document.getElementById('fileName').textContent = file.name;
        document.getElementById('fileSize').textContent = 'Tamaño: ' + (file.size / 1024).toFixed(2) + ' KB';
        document.getElementById('fileType').textContent = 'Tipo: ' + (file.type || 'Desconocido');
        fileInfo.classList.add('active');
        uploadBtn.innerHTML = '&#10003; ' + file.name;
        uploadBtn.classList.remove('btn-outline-primary');
        uploadBtn.classList.add('btn-primary');
    }
})();
</script>