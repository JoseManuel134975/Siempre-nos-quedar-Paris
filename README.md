# Siempre-nos-quedar-Paris
Volvemos a retomar una tarea que ya hicimos:

Terraform.
GithubActions.
Bucket S3 como servidor web.
Página de IA y automatización con muchos efectos (como si fuera para Ana).
Cómo posiblemente algo se me olvide pues se admiten añadidos.
Añadimos un supuesto mío:

En una empresa es obvio que varias personas pueden querer trabajar a la vez con terraform y por ende con la infraestructura. Eso no es de recibo por lo que tenemos que encontrar la manera de que dos personas no modifiquen a la vez. Suena a tfstate, bucket y dinamoDB.
y otro supuesto de Begoña:

Si tenemos EBS y solo nos permite acceder de uno en uno es buena idea almacenar el tfstate allí (creo que se refería a los pods pero ella lo expande) vamos a probarlo.
