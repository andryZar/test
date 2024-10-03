"use strict";

let grid;
const tableGridID = "#main-grid";
let tableGrid = $(tableGridID);

const mainJs = (function () {
	var handleDatatables = () => {
		let table = tableGrid.DataTable({
			dom: `<'row'<'col-sm-6'l><'col-sm-6'p>>
            <'row'<'col-sm-12'tr>>
			      <'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7 dataTables_pager'p>>`,
			scrollY: "40vh",
			scrollX: true,
			scrollCollapse: true,
			lengthMenu: [10, 25, 50],
			pageLength: 10,
			language: {
				sProcessing: "Procesando...",
				sLengthMenu: "Mostrar _MENU_ registros",
				sZeroRecords: "No se encontraron resultados",
				sEmptyTable: "Ningún dato disponible en esta tabla",
				sInfo:
					"Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
				sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
				sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
				sInfoPostFix: "",
				sSearch: "Buscar:",
				sUrl: "",
				sInfoThousands: ",",
				sLoadingRecords: "Cargando...",
				oPaginate: {
					sFirst: "Primero",
					sLast: "Último",
					sNext: "Siguiente",
					sPrevious: "Anterior",
				},
				oAria: {
					sSortAscending:
						": Activar para ordenar la columna de manera ascendente",
					sSortDescending:
						": Activar para ordenar la columna de manera descendente",
				},
			},
			searchDelay: 500,
			processing: true,
			serverSide: true,
			// deferLoading: 0,
			ajax: {
				url: `${pageUrl}/datatable`,
				type: "POST",
				data: {
					columnsDef: [
						{ value: "id", type: "num" },
						{ value: "fullname", type: "string" },
						{ value: "username", type: "string" },
						{ value: "email", type: "string" },
						{ value: "is_active", type: "num" },
						{ value: "actions", type: "num" },
					],
				},
				error: function (xhr, error, code) {
					if (xhr.status === 401) {
						return alert("Unauthorize");
					}

					if (error) return Swal.fire("", `${code}`);
				},
			},
			columns: [
				{ data: "id" },
				{ data: "fullname" },
				{ data: "username" },
				{ data: "email" },
				{ data: "is_active" },
				{ data: "actions", responsivePriority: -1 },
			],
			order: [[1, "asc"]],
			columnDefs: [
				{
					targets: [0],
					className: "text-center",
					orderable: false,
					searchable: false,
				},
				{
					targets: [1, 2],
					className: "text-center",
				},
				{
					targets: [3],
					className: "text-left",
				},
				{
					targets: [4],
					className: "text-center",
					render: (data, type, full, meta) => {
						const is_checked = parseInt(data);
						const inputID = `is_active_${full.id}`;

						return DTUtils.toggleCheckbox(inputID, is_checked);
					},
				},
				{
					targets: -1,
					className: "text-center",
					orderable: false,
					searchable: false,
					render: (data, type, full, meta) => DTUtils.editDeleteButton(full),
				},
			],
			initComplete: function () {
				$(`${tableGridID}_filter input`).unbind();
				$(`${tableGridID}_filter input`).bind("keyup", function (e) {
					const value = this.value;
					if (e.keyCode == 13 || value.length == 0)
						table.search(this.value).draw();
				});

				var rowFilter = $('<tr class="filter"></tr>').appendTo(
					// $(table.table().header())
					$(tableGrid.DataTable().table().header())
				);

				this.api()
					.columns()
					.every(function () {
						const column = this;
						const actionsPointer = "actions";
						let input;
						switch (column.title()) {
							case "fullname":
							case "username":
							case "email":
								input = $(
									`<input type="text" class="form-control form-control-sm form-filter filter-input mx-auto" data-col-index="` +
										column.index() +
										`"/>`
								);

								$(input).keyup(function (e) {
									e.preventDefault();
									const value = this.value;
									var code = e.which;
									if (code === 13 || value.length == 0) {
										$(this)
											.closest("tr")
											.find("button.grid-search")
											.trigger("click");
									}
								});
								break;
							case "is_active":
								// Create select element
								input = document.createElement("select");
								input.add(new Option("Todos", -1, true));
								input.add(new Option("No Activo", 0));
								input.add(new Option("Activo", 1));

								input.className =
									"form-control form-control-sm form-filter filter-input mx-auto";
								input.setAttribute("data-col-index", column.index());

								$(input).on("change", function (e) {
									$(this)
										.closest("tr")
										.find("button.grid-search")
										.trigger("click");
								});

								break;
							case actionsPointer:
								DTUtils.drawSearchResetButton(table, rowFilter);
								break;
						}
						if (column.title() !== actionsPointer) {
							$(input).appendTo($("<th>").appendTo(rowFilter));
						}
					});
			},
		});

		DTUtils.drawNumber(table);
		// DTUtils.singleRowSelection(table);
		// DTUtils.multiRowSelection(table)
		table.on("click", "tbody div.edit-data", function () {
			var data = table.row($(this).parents("tr")).data(); // Obtener los datos de la fila

			// Rellenar los campos del modal con los datos actuales
			$("#editUserModal #userId").val(data.id);
			$("#editUserModal #fullname").val(data.fullname);
			$("#editUserModal #username").val(data.username);
			$("#editUserModal #email").val(data.email);

			// Abrir el modal
			$("#editUserModal").modal("show");
		});

		// Manejar el envío del formulario para la creación
		$("#createUserForm").on("submit", function (e) {
			e.preventDefault();

			// Obtener los datos del formulario
			var formData = $(this).serialize();

			// Enviar la solicitud AJAX al backend para crear los datos
			$.ajax({
				url: `${pageUrl}/create`, // URL del método update en el backend
				type: "POST",
				data: formData,
				success: function (response) {
					if (response.success) {
						Swal.fire({
							title: "Éxito",
							text: response.message,
							icon: "success",
						});

						// Cerrar el modal y refrescar la tabla
						$("#createUserModal").modal("hide");
						table.draw();
					} else {
						Swal.fire({
							title: "Error",
							text: response.message,
							icon: "error",
						});
					}
				},
				error: function (xhr, status, error) {
					Swal.fire({
						title: "Error",
						text: "Ocurrió un error al actualizar el registro. Por favor, intenta de nuevo.",
						icon: "error",
					});
				},
			});
		});

		// Manejar el envío del formulario para la actualización
		$("#editUserForm").on("submit", function (e) {
			e.preventDefault();

			// Obtener los datos del formulario
			var formData = $(this).serialize();

			// Enviar la solicitud AJAX al backend para actualizar los datos
			$.ajax({
				url: `${pageUrl}/update`, // URL del método update en el backend
				type: "POST",
				data: formData,
				success: function (response) {
					if (response.success) {
						Swal.fire({
							title: "Éxito",
							text: response.message,
							icon: "success",
						});

						// Cerrar el modal y refrescar la tabla
						$("#editUserModal").modal("hide");
						table.draw();
					} else {
						Swal.fire({
							title: "Error",
							text: response.message,
							icon: "error",
						});
					}
				},
				error: function (xhr, status, error) {
					Swal.fire({
						title: "Error",
						text: "Ocurrió un error al actualizar el registro. Por favor, intenta de nuevo.",
						icon: "error",
					});
				},
			});
		});

		table.on("click", "tbody div.delete-data", function () {
			var data = table.row($(this).parents("tr")).data(); // Obtener los datos de la fila

			Swal.fire({
				title: "¿Estás seguro?",
				text: "¡No podrás revertir esto!",
				icon: "warning",
				showCancelButton: true,
				confirmButtonColor: "#3085d6",
				cancelButtonColor: "#d33",
				confirmButtonText: "Sí, eliminarlo",
				cancelButtonText: "Cancelar",
			}).then((result) => {
				if (result.isConfirmed) {
					// Llamada AJAX para eliminar el registro en el backend
					$.ajax({
						url: `${pageUrl}/delete`, // Apunta a la URL del método delete en el backend
						type: "POST",
						data: {
							id: data.id, // El ID del registro que se va a eliminar
						},
						success: function (response) {
							if (response.success) {
								Swal.fire({
									title: "Eliminado",
									text: response.message,
									icon: "success",
								});
								table.draw(); // Refrescar la tabla para mostrar los cambios
							} else {
								Swal.fire({
									title: "Error",
									text: response.message,
									icon: "error",
								});
							}
						},
						error: function (xhr, status, error) {
							Swal.fire({
								title: "Error",
								text: "Ocurrió un error al intentar eliminar el registro. Por favor, intenta de nuevo.",
								icon: "error",
							});
						},
					});
				}
			});
		});

		table.on("change", "tbody input.dtutils-toggle-checkbox", function () {
			const checkbox = $(this);
			const isChecked = checkbox.prop("checked") ? 1 : 0; // Obtener el estado actual del checkbox
			const recordID = checkbox.attr("id").split("_")[2]; // Obtener el ID del registro (usando el ID del checkbox, que debe seguir un formato específico, como `is_active_123`)

			Swal.fire({
				title: "¿Estás seguro?",
				text: "¿Deseas cambiar el estado de este registro?",
				icon: "info",
				showCancelButton: true,
				confirmButtonText: "Sí",
				cancelButtonText: "Cancelar",
			}).then(function (result) {
				if (result.isConfirmed) {
					// Llamada AJAX para actualizar el estado en el backend
					$.ajax({
						url: `${pageUrl}/updateStatus`, // La URL donde enviarás la actualización
						type: "POST",
						data: {
							id: recordID, // El ID del registro
							is_active: isChecked, // El nuevo estado
						},
						success: function (response) {
							// Manejar respuesta exitosa
							Swal.fire({
								title: "¡Estado actualizado!",
								text: "El estado del registro ha sido actualizado correctamente.",
								icon: "success",
							});
							// Actualizar la tabla si es necesario
							table.ajax.reload(null, false); // Recargar tabla sin perder la página actual
						},
						error: function (xhr, status, error) {
							// Manejar error
							Swal.fire({
								title: "Error",
								text: "Ocurrió un error al intentar actualizar el estado. Por favor, intenta de nuevo.",
								icon: "error",
							});
							// Restaurar el estado original del checkbox en caso de error
							checkbox.prop("checked", !isChecked);
						},
					});
				} else {
					// Restaurar el estado original si el usuario cancela
					checkbox.prop("checked", !isChecked);
				}
			});
		});

		return table;
	};

	return {
		init: () => {
			grid = handleDatatables();
		},
		delete: (data) => {
			console.log("🚀 ~ mainJs ~ data:", data);
		},
	};
})();

Cignadlte.onDOMContentLoaded(function () {
	mainJs.init();
});
