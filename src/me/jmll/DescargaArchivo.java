package me.jmll;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DownloadServlet
 */
@WebServlet({ "/DescargaArchivo", "/Descarga", "/Descarga.do", "/Download", "/Download.do" })
public class DescargaArchivo extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // obtiene la referencia a un objeto del logger
    private final static Logger LOGGER = Logger.getLogger(DescargaArchivo.class.getCanonicalName());

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DescargaArchivo() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doRequest(request, response);

    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setStatus(405);
    }

    protected void doRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	ArrayList<String> errores = new ArrayList<String>();
    	// 4(e) Cargar el resource bundle del atributo de la sessión "locale"
		Locale locale = request.getLocale();
		ResourceBundle bundle = ResourceBundle.getBundle("me.jmll.i18n.app", locale);
		
		
        // Obtener el parámetro fileName
        String fileName = request.getParameter("archivo");
        // Validar que fileName viene en la solicitud
        if (fileName != null) {
            // Obtener el contexto del servlet en la variable servletContext
            ServletContext servletContext = request.getServletContext();
            try {
                // Crea un objeto File con el path solicitado
                File fileDownload = new File(fileName);
                if (fileDownload.exists()) {
                    // Crear instancias de FileInputStrem a partir del archivo a descargar
                    //    y OutputStream a partir del objeto response
                    try (FileInputStream fileInputStream = new FileInputStream(fileDownload);
                            OutputStream outputStream = response.getOutputStream();) {

                        // Obtener MimeType del Archivo
                        String mimeType = servletContext.getMimeType(fileName);
                        if (mimeType == null)
                            mimeType = "application/octet-stream";
                        LOGGER.log(Level.INFO, "MimeType identificado: {0}", new Object[] { mimeType });
                        
                        // Crear response: MimeType
                        response.setContentType(mimeType);
                        response.setContentLength((int) fileDownload.length());
                        
                        // Crear response: Headers
                        response.setHeader("Content-Disposition",
                                String.format("attachment; filename=\"%s\";", fileDownload.getName()));
                        LOGGER.log(Level.INFO, "Iniciando transferencia de {0} {1} Bytes a {2}", new Object[] {
                                fileDownload.getName(), fileDownload.length(), request.getRemoteAddr() });
                        // Transmite datos
                        byte[] buffer = new byte[4096];
                        int bytesRead = -1;

                        while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }
                        LOGGER.log(Level.INFO, "Transferencia completada {0}", fileDownload.getName());
                    }

                } else {
                    errores.add(String.format(bundle.getString("app.download.error"), fileName));
                    request.setAttribute("errores", errores);
        			request.getRequestDispatcher("/Admin.do").forward(request, response);
                }

            } catch (Exception ex) {
                errores.add(String.format(bundle.getString("app.download.error"), ex));
                LOGGER.log(Level.SEVERE, "Problemas durante la descarga de archivo. Error: {0}",
                        new Object[] { ex.getMessage() });
                request.setAttribute("errores", errores);
    			request.getRequestDispatcher("/Admin.do").forward(request, response);
            }
        } else {
        	errores.add(String.format(bundle.getString("app.download.error")));
            request.setAttribute("errores", errores);
			request.getRequestDispatcher("/Admin.do").forward(request, response);
        }
    }

}
