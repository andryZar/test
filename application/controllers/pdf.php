<?php
defined('BASEPATH') OR exit('No direct script access allowed');

use Mpdf\Mpdf; 

class Pdf extends CI_Controller {

    public function index()
    {
        $this->template
            ->page_title('Generación de PDF')
            ->load('pdf');
    }

    public function generate_pdf()
    {
        // Obtener la lista de usuarios
        $this->load->model('users');
        $param = [
            'select' => ['id', 'fullname', 'username', 'email'],
            'where' => [
                'is_active' => 1
            ]
        ];

        $query = $this->users->find($param);

        // Crear contenido HTML
        $html = '<h1>Lista de Usuarios</h1>';
        $html .= '<table border="1" cellpadding="10" cellspacing="0">';
        $html .= '<thead><tr><th>ID</th><th>Nombre Completo</th><th>Nombre de Usuario</th><th>Email</th></tr></thead>';
        $html .= '<tbody>';

        foreach ($query->result() as $user) {
            $html .= '<tr>';
            $html .= '<td>' . $user->id . '</td>';
            $html .= '<td>' . $user->fullname . '</td>';
            $html .= '<td>' . $user->username . '</td>';
            $html .= '<td>' . $user->email . '</td>';
            $html .= '</tr>';
        }

        $html .= '</tbody></table>';

        // Generar el PDF
        try {
            $mpdf = new Mpdf(); // Asegúrate de usar el espacio de nombres correcto
            $mpdf->WriteHTML($html);
            $mpdf->Output('usuarios.pdf', 'I'); // 'D' para descargar, 'I' para mostrar en el navegador
        } catch (\Mpdf\MpdfException $e) { // Captura de excepciones
            echo $e->getMessage();
        }
    }
}
