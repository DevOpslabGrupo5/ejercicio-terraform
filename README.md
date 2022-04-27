# ejercicio-terraform
Modulo 5 - Actividad S11 Terraform

Se Requiere habilitar un ambiente de ci/cd para esto es necesario que en el ambiente se pueda
compilar en jenkins y desplegar en kubernetes.
requerimientos mediante terraform se debe:

1) Crear una máquina en la cual se pueda instalar jenkins(Mediante ansible).
2) Crear un cluster kubernetes el cual tenga:
2.1) Kubernetes version 1.22.4
2.2) autoescalado entre 1 a 3 nodos
2.3) Azure Network.
2.4) Azure policy
2.5) habilitar Rbac.
2.6) agregar pool de nodos adicional con label: Adicional
2.7) especificar la cantidad de pod por nodo en: 80
subir el codigo tf a algún repositorio git y enviar el link de acceso a la moodle.
