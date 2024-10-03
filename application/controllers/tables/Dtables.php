<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Dtables extends CI_Controller {
	public function index()
	{
		$this->template
			->page_title('Lista de usuarios')
      ->plugins(['datatables'])
			->page_js('assets/dist/js/pages/datatables.js')
      ->load('tables/datatables');

		// $this->template->load();
	}


  public function create()
{
    // Obtener los datos del formulario enviados por AJAX
    $fullname = $this->input->post('fullname', TRUE);
    $username = $this->input->post('username', TRUE);
    $email = $this->input->post('email', TRUE);

    // Validar los campos requeridos
    if (!$fullname || !$username || !$email) {
        return $this->response->json(['success' => false, 'message' => 'Todos los campos son obligatorios.']);
    }

    // Cargar el modelo de usuarios
    $this->load->model('users');

    // Datos a insertar
    $data = [
        'fullname' => $fullname,
        'username' => $username,
        'email' => $email,
        'is_active' => 1 // Por defecto, el nuevo usuario estará activo
    ];

    // Insertar los datos en la base de datos
    $insertResult = $this->db->insert('users', $data);

    // Verificar si la inserción fue exitosa
    if ($insertResult) {
        return $this->response->json(['success' => true, 'message' => 'Usuario creado correctamente.']);
    } else {
        return $this->response->json(['success' => false, 'message' => 'Error al crear el usuario.']);
    }
}


  public function update()
{
    // Obtener los datos del formulario enviados por AJAX
    $userId = $this->input->post('id', TRUE);
    $fullname = $this->input->post('fullname', TRUE);
    $username = $this->input->post('username', TRUE);
    $email = $this->input->post('email', TRUE);

    // Validar los campos requeridos
    if (!$userId || !$fullname || !$username || !$email) {
        return $this->response->json(['success' => false, 'message' => 'Todos los campos son obligatorios.']);
    }

    // Cargar el modelo de usuarios
    $this->load->model('users');

    // Datos a actualizar
    $data = [
        'fullname' => $fullname,
        'username' => $username,
        'email' => $email,
    ];

    // Actualizar los datos en la base de datos
    $updateResult = $this->db->update('users', $data, ['id' => $userId]);

    // Verificar si la actualización fue exitosa
    if ($updateResult) {
        return $this->response->json(['success' => true, 'message' => 'Usuario actualizado correctamente.']);
    } else {
        return $this->response->json(['success' => false, 'message' => 'Error al actualizar el usuario.']);
    }
}


  public function delete()
{
    // Obtener el ID del usuario desde la solicitud AJAX
    $userId = $this->input->post('id', TRUE);

    // Verificar si el ID es válido
    if (is_null($userId)) {
        // Responder con error si no hay datos válidos
        return $this->response->json(['success' => false, 'message' => 'ID de usuario no válido.']);
    }

    // Cargar el modelo que gestiona los usuarios (assume que es 'users')
    $this->load->model('users');

    // Eliminar el registro de la base de datos
    $deleteResult = $this->db->delete('users', ['id' => $userId]); // Asume que la tabla es 'users'

    // Verificar si la eliminación fue exitosa
    if ($deleteResult) {
        return $this->response->json(['success' => true, 'message' => 'Usuario eliminado correctamente.']);
    } else {
        return $this->response->json(['success' => false, 'message' => 'Error al eliminar el usuario.']);
    }
}


  public function updateStatus()
{
    // Obtener el ID del usuario y el nuevo estado desde la solicitud AJAX
    $userId = $this->input->post('id', TRUE);
    $newStatus = $this->input->post('is_active', TRUE);

    // Verificar si los datos son válidos
    if (is_null($userId) || !isset($newStatus)) {
        // Responder con error si no hay datos válidos
        return $this->response->json(['success' => false, 'message' => 'Datos inválidos.']);
    }

    // Cargar el modelo que gestiona los usuarios (assume que es 'users')
    $this->load->model('users');

    // Actualizar el estado del usuario en la base de datos
    $data = ['is_active' => $newStatus];
    $this->db->where('id', $userId);
    $updateResult = $this->db->update('users', $data); // Asume que la tabla es 'users'

    // Verificar si la actualización fue exitosa
    if ($updateResult) {
        return $this->response->json(['success' => true, 'message' => 'Estado actualizado correctamente.']);
    } else {
        return $this->response->json(['success' => false, 'message' => 'Error al actualizar el estado.']);
    }
}

	public function datatable()
	{
		// load the main model in here
		$this->load->model('users', 'dt_model');

		/**
     * @var array  $columns
     * @var array  $columnsDef
     * @var array  $order
     * @var array  $search
     * @var integer  $start
     * @var integer  $length
     */
		$columns = $this->input->post('columns', TRUE) ?? [];
		$columnsDef = $this->input->post('columnsDef', TRUE) ?? [];
		$orders = $this->input->post('order', TRUE) ?? [];
		$search = $this->input->post('search', TRUE) ?? [];
		$start = $this->input->post('start', TRUE);
		$length = $this->input->post('length', TRUE);

		// additional filter parameter goes here


		// start init $configs
    // must have parameter, add default filter value in here too if there are any
    $where = [];
    $where_false = [];

		// set default config
		$configs = [
			'where' => $where,
			'where_false' => $where_false,
		];

		// Join/s table goes here
    // join can only be use for joining one table, as an array with parameter table, on, and type
    // joins can be use for either joining one or more table/s as an array containt join parameter as an array 
		$configs['joins'] = [];

		// get total rows on the table without any filter
    $recordsTotal = $this->dt_model->find(['count_all' => true]);

		// order
    // get order param
    $orderBy = $this->datatables->getOrder($columns, $orders);
    if($orderBy) $configs['order_by'] = implode(' ', $orderBy);

		// search
    // get the search param
		// use getSimpleSearch($columns, $search) if datatable is using a simple search
		// use getIndividualSearch($columns, $columnsDef) if datatable is using individual search column
		$searchParam = $this->datatables->getIndividualSearch($columns, $columnsDef);
		$configs = array_merge_recursive($configs, $searchParam);

		// set column and other needed state
    // $numbering_over and $numbering_row is only for mysql 8++, postgresql, and sql server,
    // it creating auto numbering base on the order
    // if you dont use them then try another approach
    // $numbering_over = ($orderBy) ? "ORDER BY {$orderBy['column']} {$orderBy['dir']}" : "";
    // $numbering_row = "ROW_NUMBER() OVER({$numbering_over}) as no ";
		$select = [
      'id', 
      'fullname', 
      'username', 
      'email', 
      'is_active'
      // $numbering_row
    ];

		// set select on condition configs
    $configs['select'] = $select;

    // get total rows with filter
    $configs['count_all_results'] = true;
    $recordsFiltered = $this->dt_model->find($configs, false);
    unset($configs['count_all_results']);

		// limit
    $configs['limit'] = ['length' => $length, 'start' => $start];

    // get all limited filtered data
    $query = $this->dt_model->find($configs, false);
    $data = $query->status && $query->num_rows() ? $query->result() : [];

		// compile select
		// just for debuging, comment this if dont want to use it
		$configs['compile_select'] = true;
		$sql = $this->dt_model->find($configs);

		$response = [
			"sql" => $sql, // comment this if not using compile select
      "recordsTotal" => $recordsTotal,
      "recordsFiltered" => $recordsFiltered,
      "data" => $data,
			"sparam" => $searchParam
    ];

		return $this->response->json($response);
	}
}
