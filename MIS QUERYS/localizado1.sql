select cr.nombreruta,rm.custnmbr Codigo,rm1.custname Nombre,rm1.address1 Direccion1,rm1.address2 Direccion2,rm1.address3 Direccion3,rm.userdef1 Latitud,rm.userdef2 Longitud from rm00102 rm join rm00101 rm1 on rm.custnmbr = rm1.custnmbr join palmcomsync..gp_clientediasruta cr on rm.custnmbr = cr.codcliente
where rm.userdef1 <>0

select * from palmcomsync..gp_clientediasruta