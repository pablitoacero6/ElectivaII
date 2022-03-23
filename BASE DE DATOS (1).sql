--------------------------------------------------------
-- Archivo creado  - mi�rcoles-marzo-23-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type BENEFICIARIO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TYPE "DANIELBRMDZ"."BENEFICIARIO" AS OBJECT(
    id_beneficiario VARCHAR2(5),
	nombre	VARCHAR2(40),
	numero_cuenta 	VARCHAR2(20),
	tipo_documento	VARCHAR2(10),
    numero_documento VARCHAR2(15),
    id_banco VARCHAR2(3),
	CONSTRUCTOR FUNCTION beneficiario
		RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION beneficiario(id_beneficiario VARCHAR2,nombre VARCHAR2,numero_cuenta VARCHAR2,tipo_documento VARCHAR2,numero_documento VARCHAR2, id_banco VARCHAR2)
		RETURN SELF AS RESULT,
    -- sets    
    MEMBER PROCEDURE set_id_beneficiario(id_beneficiario VARCHAR2 DEFAULT NULL),
	MEMBER PROCEDURE set_nombre(nombre VARCHAR2 DEFAULT NULL),
	MEMBER PROCEDURE set_numero_cuenta(numero_cuenta VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_tipo_documento(tipo_documento VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_numero_documento(numero_documento VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_id_banco(id_banco VARCHAR2 DEFAULT NULL),
    
    --gets
    MEMBER FUNCTION set_id_beneficiario RETURN VARCHAR2,
    MEMBER FUNCTION set_nombre RETURN VARCHAR2,
    MEMBER FUNCTION set_numero_cuenta RETURN VARCHAR2,
    MEMBER FUNCTION set_tipo_documento RETURN VARCHAR2,
    MEMBER FUNCTION set_numero_documento RETURN VARCHAR2,
    MEMBER FUNCTION set_id_banco RETURN VARCHAR2
	);
/
CREATE OR REPLACE NONEDITIONABLE TYPE BODY "DANIELBRMDZ"."BENEFICIARIO" 
IS
	CONSTRUCTOR FUNCTION beneficiario
		RETURN SELF AS RESULT
	IS
	BEGIN
		RETURN;
	END;

	CONSTRUCTOR FUNCTION beneficiario(id_beneficiario VARCHAR2,nombre VARCHAR2,numero_cuenta VARCHAR2,tipo_documento VARCHAR2,numero_documento VARCHAR2, id_banco VARCHAR2)
	RETURN SELF AS RESULT
	IS
	BEGIN
        SELF.id_beneficiario := id_beneficiario;
		SELF.nombre := nombre;
        SELF.numero_cuenta  := numero_cuenta;	
        SELF.tipo_documento :=	tipo_documento;
        SELF.numero_documento := numero_documento;
        SELF.id_banco := id_banco;
		RETURN;
	END;

    MEMBER PROCEDURE set_id_beneficiario(id_beneficiario VARCHAR2)
    IS 
	BEGIN 
	SELF.id_beneficiario := id_beneficiario;
	END;

    MEMBER PROCEDURE set_nombre(nombre VARCHAR2)
    IS 
	BEGIN 
	SELF.nombre := nombre;
	END;

	MEMBER PROCEDURE set_numero_cuenta(numero_cuenta VARCHAR2)
      IS 
	BEGIN 
	SELF.numero_cuenta  := numero_cuenta;	
	END;

    MEMBER PROCEDURE set_tipo_documento(tipo_documento VARCHAR2)
      IS 
	BEGIN 
	SELF.tipo_documento :=	tipo_documento;
	END;
    MEMBER PROCEDURE set_numero_documento(numero_documento VARCHAR2)
      IS 
	BEGIN 
	SELF.numero_documento := numero_documento;
	END;
    MEMBER PROCEDURE set_id_banco(id_banco VARCHAR2)
      IS 
	BEGIN 
	 SELF.id_banco := id_banco;
	END;

    MEMBER FUNCTION set_id_beneficiario RETURN VARCHAR2 IS
  BEGIN
    RETURN id_beneficiario;
  END;
    MEMBER FUNCTION set_nombre RETURN VARCHAR2 IS
  BEGIN
    RETURN nombre;
  END;
    MEMBER FUNCTION set_numero_cuenta RETURN VARCHAR2 IS
  BEGIN
    RETURN numero_cuenta;
  END;
    MEMBER FUNCTION set_tipo_documento RETURN VARCHAR2 IS
  BEGIN
    RETURN tipo_documento;
  END;
    MEMBER FUNCTION set_numero_documento RETURN VARCHAR2 IS
  BEGIN
    RETURN numero_documento;
  END;
    MEMBER FUNCTION set_id_banco RETURN VARCHAR2 IS
  BEGIN
    RETURN id_banco;
  END;
END;

/
--------------------------------------------------------
--  DDL for Type BENEFICIARIOS
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TYPE "DANIELBRMDZ"."BENEFICIARIOS" AS ARRAY(10) OF beneficiario ;

/
--------------------------------------------------------
--  DDL for Type CUENTA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TYPE "DANIELBRMDZ"."CUENTA" AS OBJECT(
    numero_cuenta VARCHAR2(18),
	divisa VARCHAR2(3),
	saldo DEC(12,2),
	valor_sobregiro	DEC(12,2),
    fecha_creacion DATE,
    lista_beneficiarios beneficiarios,
	CONSTRUCTOR FUNCTION cuenta
		RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION cuenta(numero_cuenta VARCHAR2,divisa VARCHAR2,saldo DEC,fecha_creacion DATE )
		RETURN SELF AS RESULT,
    --sets
    MEMBER PROCEDURE set_numero_cuenta(numero_cuenta VARCHAR2 DEFAULT NULL),    
	MEMBER PROCEDURE set_divisa(divisa VARCHAR2 DEFAULT NULL),
	MEMBER PROCEDURE set_saldo(saldo DEC DEFAULT NULL),
    MEMBER PROCEDURE set_valor_sobregiro(valor_sobregiro DEC DEFAULT NULL),
    MEMBER PROCEDURE set_fecha_creacion(fecha_creacion DATE DEFAULT NULL),
    MEMBER PROCEDURE add_beneficiario(new_beneficiario beneficiario DEFAULT NULL),
    --gets
    MEMBER FUNCTION get_numero_cuenta RETURN VARCHAR2,
    MEMBER FUNCTION get_divisa RETURN VARCHAR2,
    MEMBER FUNCTION get_saldo RETURN DEC,
    MEMBER FUNCTION get_valor_sobregiro RETURN DEC,
    MEMBER FUNCTION get_fecha_creacion RETURN DATE,
    MEMBER FUNCTION get_beneficiarios RETURN beneficiarios,
    MEMBER FUNCTION get_num_beneficiarios RETURN NUMBER
	);
/
CREATE OR REPLACE NONEDITIONABLE TYPE BODY "DANIELBRMDZ"."CUENTA" 
IS
	CONSTRUCTOR FUNCTION cuenta
		RETURN SELF AS RESULT
	IS
	BEGIN
        lista_beneficiarios := beneficiarios();
		RETURN;
	END;

	CONSTRUCTOR FUNCTION cuenta(numero_cuenta VARCHAR2,divisa VARCHAR2,saldo DEC,fecha_creacion DATE )
	RETURN SELF AS RESULT
	IS
	BEGIN
        SELF.numero_cuenta := numero_cuenta;
		SELF.divisa := divisa;
        SELF.saldo  := saldo;	
        SELF.valor_sobregiro :=	0.25*saldo;
        SELF.fecha_creacion := fecha_creacion;
        lista_beneficiarios := beneficiarios();
		RETURN;
	END;
    MEMBER PROCEDURE set_numero_cuenta(numero_cuenta VARCHAR2)
    IS 
	BEGIN 
	SELF.numero_cuenta := numero_cuenta;
	END; 
    MEMBER PROCEDURE set_divisa(divisa VARCHAR2)
    IS 
	BEGIN 
	SELF.divisa := divisa;
	END;
	MEMBER PROCEDURE set_saldo(saldo DEC)
      IS 
	BEGIN 
	SELF.saldo  := saldo;
    IF (valor_sobregiro < saldo *0.25) THEN
         SELF.valor_sobregiro :=  (saldo * 0.25 );
    END IF;
	END;
    MEMBER PROCEDURE set_valor_sobregiro(valor_sobregiro DEC)
      IS 
	BEGIN 
	 SELF.valor_sobregiro := valor_sobregiro;
	END;
    MEMBER PROCEDURE set_fecha_creacion(fecha_creacion DATE)
      IS 
	BEGIN 
	 SELF.fecha_creacion := fecha_creacion;
	END;
    MEMBER PROCEDURE add_beneficiario(new_beneficiario beneficiario)
      IS 
	BEGIN
    lista_beneficiarios.EXTEND;
    lista_beneficiarios(lista_beneficiarios.LAST) := new_beneficiario;
	END;

     MEMBER FUNCTION get_numero_cuenta RETURN VARCHAR2 IS
  BEGIN
    RETURN numero_cuenta;
  END;
    MEMBER FUNCTION get_divisa RETURN VARCHAR2 IS
  BEGIN
    RETURN divisa;
  END;
    MEMBER FUNCTION get_saldo RETURN DEC IS
  BEGIN
    RETURN saldo;
  END;
    MEMBER FUNCTION get_valor_sobregiro RETURN DEC IS
  BEGIN
    RETURN valor_sobregiro;
  END;
    MEMBER FUNCTION get_fecha_creacion RETURN DATE IS
  BEGIN
    RETURN fecha_creacion;
  END;
    MEMBER FUNCTION get_beneficiarios RETURN beneficiarios IS
  BEGIN
    RETURN lista_beneficiarios;
  END;
   MEMBER FUNCTION get_num_beneficiarios RETURN NUMBER IS
  BEGIN
    RETURN lista_beneficiarios.count;
  END;
END;

/
--------------------------------------------------------
--  DDL for Type CUENTAS
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TYPE "DANIELBRMDZ"."CUENTAS" AS ARRAY(10) OF cuenta ;

/
--------------------------------------------------------
--  DDL for Type CLIENTE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TYPE "DANIELBRMDZ"."CLIENTE" AS OBJECT(
    id_cliente VARCHAR2(5),
	nombres	VARCHAR2(40),
	apellidos 	VARCHAR2(50),
    fecha_nacimiento DATE,
    tipo_documento VARCHAR2(10),
    numero_documento VARCHAR2(15),
    direccion VARCHAR2(20),
    estado_cliente CHAR(1),
    lista_cuentas cuentas,
	CONSTRUCTOR FUNCTION cliente
		RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION cliente(id_cliente VARCHAR2,nombres VARCHAR2,apellidos	VARCHAR2,fecha_nacimiento DATE,tipo_documento VARCHAR2,numero_documento VARCHAR2,direccion VARCHAR2,estado_cliente CHAR)
		RETURN SELF AS RESULT,    
    --SETS    
	MEMBER PROCEDURE set_id_cliente(id_cliente VARCHAR2 DEFAULT NULL),
	MEMBER PROCEDURE set_nombres(nombres VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_apellidos(apellidos VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_fecha_nacimiento(fecha_nacimiento DATE DEFAULT NULL),
    MEMBER PROCEDURE set_tipo_documento(tipo_documento VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_numero_documento(numero_documento VARCHAR2 DEFAULT NULL),
	MEMBER PROCEDURE set_direccion(direccion VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_estado_cliente(estado_cliente CHAR DEFAULT NULL),
    MEMBER PROCEDURE add_cuenta(new_cuenta cuenta DEFAULT NULL),
    -- GETS
    MEMBER FUNCTION get_id_cliente RETURN VARCHAR2,
    MEMBER FUNCTION get_nombres RETURN VARCHAR2,
    MEMBER FUNCTION get_apellidos RETURN VARCHAR2,
    MEMBER FUNCTION get_fecha_nacimiento RETURN DATE,
    MEMBER FUNCTION get_tipo_documento RETURN VARCHAR2,
    MEMBER FUNCTION get_numero_documento RETURN VARCHAR2,
    MEMBER FUNCTION get_direccion RETURN VARCHAR2,
    MEMBER FUNCTION get_estado_cliente RETURN CHAR,
    MEMBER FUNCTION get_cuentas RETURN cuentas
	);
/
CREATE OR REPLACE NONEDITIONABLE TYPE BODY "DANIELBRMDZ"."CLIENTE" 
IS
	CONSTRUCTOR FUNCTION cliente
		RETURN SELF AS RESULT
	IS
	BEGIN
        lista_cuentas := cuentas();
		RETURN;
	END;

	CONSTRUCTOR FUNCTION cliente(id_cliente VARCHAR2,nombres VARCHAR2,apellidos	VARCHAR2,fecha_nacimiento DATE,tipo_documento VARCHAR2,numero_documento VARCHAR2,direccion VARCHAR2,estado_cliente CHAR)
	RETURN SELF AS RESULT
	IS
	BEGIN
		SELF.id_cliente := id_cliente;
        SELF.nombres  := nombres;	
        SELF.apellidos :=	apellidos;
        SELF.fecha_nacimiento := fecha_nacimiento;
        SELF.tipo_documento := tipo_documento;
        SELF.numero_documento := numero_documento;
        SELF.direccion := direccion;
        SELF.estado_cliente  := estado_cliente;
        lista_cuentas := cuentas();
		RETURN;
	END;
    MEMBER PROCEDURE set_id_cliente(id_cliente VARCHAR2)
    IS 
	BEGIN 
	SELF.id_cliente := id_cliente;
	END;
	MEMBER PROCEDURE set_nombres(nombres VARCHAR2)
      IS 
	BEGIN 
	SELF.nombres  := nombres;
	END;
    MEMBER PROCEDURE set_apellidos(apellidos VARCHAR2)
      IS 
	BEGIN 
	SELF.apellidos :=	apellidos;
	END;
    MEMBER PROCEDURE set_fecha_nacimiento(fecha_nacimiento DATE)
      IS 
	BEGIN 
	SELF.fecha_nacimiento := fecha_nacimiento;
	END;
    MEMBER PROCEDURE set_tipo_documento(tipo_documento VARCHAR2)
      IS 
	BEGIN 
	SELF.tipo_documento := tipo_documento;
	END;
    MEMBER PROCEDURE set_numero_documento(numero_documento VARCHAR2)
      IS 
	BEGIN 
	SELF.numero_documento := numero_documento;
	END;
	MEMBER PROCEDURE set_direccion(direccion VARCHAR2)
      IS 
	BEGIN 
	SELF.direccion := direccion;
	END;
    MEMBER PROCEDURE set_estado_cliente(estado_cliente CHAR)
      IS 
	BEGIN 
	SELF.estado_cliente  := estado_cliente;
	END;
    MEMBER PROCEDURE add_cuenta(new_cuenta cuenta)
      IS 
	BEGIN
    lista_cuentas.EXTEND;
    lista_cuentas(lista_cuentas.LAST) := new_cuenta;
	END;

  MEMBER FUNCTION get_id_cliente RETURN VARCHAR2 IS
  BEGIN
    RETURN id_cliente;
  END;
    MEMBER FUNCTION get_nombres RETURN VARCHAR2 IS
  BEGIN
    RETURN nombres;
  END;
    MEMBER FUNCTION get_apellidos RETURN VARCHAR2 IS
  BEGIN
    RETURN apellidos;
  END;
    MEMBER FUNCTION get_fecha_nacimiento RETURN DATE IS
  BEGIN
    RETURN fecha_nacimiento;
  END;
    MEMBER FUNCTION get_tipo_documento RETURN VARCHAR2 IS
  BEGIN
    RETURN tipo_documento;
  END;
    MEMBER FUNCTION get_numero_documento RETURN VARCHAR2 IS
  BEGIN
    RETURN numero_documento;
  END;
    MEMBER FUNCTION get_direccion RETURN VARCHAR2 IS
  BEGIN
    RETURN direccion;
  END;
    MEMBER FUNCTION get_estado_cliente RETURN CHAR  IS
  BEGIN
    RETURN estado_cliente;
  END;
    MEMBER FUNCTION get_cuentas RETURN cuentas  IS
  BEGIN
    RETURN lista_cuentas;
  END;    
END;

/
--------------------------------------------------------
--  DDL for Type TRANSACCION
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TYPE "DANIELBRMDZ"."TRANSACCION" AS OBJECT(
    id_transaccion VARCHAR2(20),
    id_cliente VARCHAR2(5),
	numero_cuenta VARCHAR2(12),
    id_cliente_2 VARCHAR2(5),
	numero_cuenta_2	VARCHAR2(12),
    id_banco VARCHAR2(3),
    valor_transferencia DEC(12,2),
    divisa VARCHAR2(3),
    fecha_transaccion DATE,
    cod_mensaje VARCHAR(1),
    estado_transaccion CHAR(1),
	CONSTRUCTOR FUNCTION transaccion
		RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION transaccion(id_transaccion VARCHAR2,id_cliente VARCHAR2,numero_cuenta VARCHAR2,id_cliente_2 VARCHAR2,numero_cuenta_2 VARCHAR2,id_banco VARCHAR2,valor_transferencia DEC,divisa VARCHAR2,fecha_transaccion DATE,cod_mensaje VARCHAR,estado_transaccion CHAR)
		RETURN SELF AS RESULT,
    --SETS
    MEMBER PROCEDURE set_id_transaccion(id_transaccion VARCHAR2 DEFAULT NULL),
	MEMBER PROCEDURE set_id_cliente(id_cliente VARCHAR2 DEFAULT NULL),    
	MEMBER PROCEDURE set_numero_cuenta(numero_cuenta VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_id_cliente_2(id_cliente_2 VARCHAR2 DEFAULT NULL),    
	MEMBER PROCEDURE set_numero_cuenta_2(numero_cuenta_2 VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_id_banco(id_banco VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_valor_transferencia(valor_transferencia DEC DEFAULT NULL),
    MEMBER PROCEDURE set_divisa(divisa VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_fecha_transaccion(fecha_transaccion DATE DEFAULT NULL),
    MEMBER PROCEDURE set_cod_mensaje(cod_mensaje VARCHAR2 DEFAULT NULL),
	MEMBER PROCEDURE set_estado_transaccion(estado_transaccion CHAR DEFAULT NULL),
    --GETS
    MEMBER FUNCTION get_id_transaccion RETURN VARCHAR2,
    MEMBER FUNCTION get_id_cliente RETURN VARCHAR2,
    MEMBER FUNCTION get_numero_cuenta RETURN VARCHAR2,
    MEMBER FUNCTION get_id_cliente_2 RETURN VARCHAR2,    
    MEMBER FUNCTION get_numero_cuenta_2 RETURN VARCHAR2,
    MEMBER FUNCTION get_id_banco RETURN VARCHAR2,
    MEMBER FUNCTION get_valor_transferencia RETURN DEC,
    MEMBER FUNCTION get_divisa RETURN VARCHAR2,
    MEMBER FUNCTION get_fecha_transaccion RETURN DATE,
    MEMBER FUNCTION get_cod_mensaje RETURN VARCHAR2,
    MEMBER FUNCTION get_estado_transaccion RETURN CHAR
	);
/
CREATE OR REPLACE NONEDITIONABLE TYPE BODY "DANIELBRMDZ"."TRANSACCION" 
IS
	CONSTRUCTOR FUNCTION transaccion
		RETURN SELF AS RESULT
	IS
	BEGIN
		RETURN;
	END;

	CONSTRUCTOR FUNCTION transaccion(id_transaccion VARCHAR2,id_cliente VARCHAR2,numero_cuenta VARCHAR2,id_cliente_2 VARCHAR2,numero_cuenta_2 VARCHAR2,id_banco VARCHAR2,valor_transferencia DEC,divisa VARCHAR2,fecha_transaccion DATE,cod_mensaje VARCHAR,estado_transaccion CHAR)
	RETURN SELF AS RESULT
	IS
	BEGIN
        SELF.id_transaccion := id_transaccion;
        SELF.id_cliente  := id_cliente;	
		SELF.numero_cuenta := numero_cuenta;
        SELF.id_cliente_2  := id_cliente_2;	
        SELF.numero_cuenta_2  := numero_cuenta_2;	
        SELF.id_banco := id_banco;
        SELF.valor_transferencia := valor_transferencia;
        SELF.divisa := divisa;
        SELF.fecha_transaccion := fecha_transaccion;
        SELF.cod_mensaje := cod_mensaje;
        SELF.estado_transaccion := estado_transaccion;
		RETURN;
	END;

    MEMBER PROCEDURE set_id_transaccion(id_transaccion VARCHAR2)
    IS 
	BEGIN 
	SELF.id_transaccion := id_transaccion;
	END;
	MEMBER PROCEDURE set_id_cliente(id_cliente VARCHAR2)
      IS 
	BEGIN 
	SELF.id_cliente  := id_cliente;	
	END;

    MEMBER PROCEDURE set_numero_cuenta(numero_cuenta VARCHAR2)
    IS 
	BEGIN 
	SELF.numero_cuenta := numero_cuenta;
	END;
    MEMBER PROCEDURE set_id_cliente_2(id_cliente_2 VARCHAR2)
      IS 
	BEGIN 
	SELF.id_cliente_2  := id_cliente_2;	
	END;
	MEMBER PROCEDURE set_numero_cuenta_2(numero_cuenta_2 VARCHAR2)
      IS 
	BEGIN 
	SELF.numero_cuenta_2  := numero_cuenta_2;	
	END; 
    MEMBER PROCEDURE set_id_banco(id_banco VARCHAR2)
      IS 
	BEGIN 
	SELF.id_banco := id_banco;
	END;
    MEMBER PROCEDURE set_valor_transferencia(valor_transferencia DEC)
      IS 
	BEGIN 
	SELF.valor_transferencia := valor_transferencia;
	END;
    MEMBER PROCEDURE set_divisa(divisa VARCHAR2)
      IS 
	BEGIN 
	SELF.divisa := divisa;
	END;
    MEMBER PROCEDURE set_fecha_transaccion(fecha_transaccion DATE)
      IS 
	BEGIN 
	SELF.fecha_transaccion := fecha_transaccion;
	END;
    MEMBER PROCEDURE set_cod_mensaje(cod_mensaje VARCHAR2)
      IS 
	BEGIN 
	SELF.cod_mensaje := cod_mensaje;
	END;
	MEMBER PROCEDURE set_estado_transaccion(estado_transaccion CHAR)
      IS 
	BEGIN 
	SELF.estado_transaccion := estado_transaccion;
	END;

    MEMBER FUNCTION get_id_transaccion RETURN VARCHAR2 IS
  BEGIN
    RETURN id_transaccion;
  END;
    MEMBER FUNCTION get_id_cliente RETURN VARCHAR2 IS
  BEGIN
    RETURN id_cliente;
  END;
    MEMBER FUNCTION get_numero_cuenta RETURN VARCHAR2 IS
  BEGIN
    RETURN numero_cuenta;
  END;
   MEMBER FUNCTION get_id_cliente_2 RETURN VARCHAR2 IS
  BEGIN
    RETURN id_cliente_2;
  END;
    MEMBER FUNCTION get_numero_cuenta_2 RETURN VARCHAR2  IS
  BEGIN
    RETURN numero_cuenta_2;
  END;
    MEMBER FUNCTION get_id_banco RETURN VARCHAR2  IS
  BEGIN
    RETURN id_banco;
  END;
    MEMBER FUNCTION get_valor_transferencia RETURN DEC IS
  BEGIN
    RETURN valor_transferencia;
  END;
    MEMBER FUNCTION get_divisa RETURN VARCHAR2 IS
  BEGIN
    RETURN divisa;
  END;
    MEMBER FUNCTION get_fecha_transaccion RETURN DATE IS
  BEGIN
    RETURN fecha_transaccion;
  END;
    MEMBER FUNCTION get_cod_mensaje RETURN VARCHAR2 IS
  BEGIN
    RETURN cod_mensaje;
  END;
    MEMBER FUNCTION get_estado_transaccion RETURN CHAR IS
  BEGIN
    RETURN estado_transaccion;
  END;
END;

/
--------------------------------------------------------
--  DDL for Type BANCO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TYPE "DANIELBRMDZ"."BANCO" AS OBJECT(
	id_banco VARCHAR2(3),
	nombre	VARCHAR2(20),
    saldo	DEC(12,2),
	CONSTRUCTOR FUNCTION banco
		RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION banco(id_banco VARCHAR2,nombre VARCHAR2,saldo	DEC)
		RETURN SELF AS RESULT,
	MEMBER PROCEDURE set_id_banco(id_registro VARCHAR2 DEFAULT NULL),
	MEMBER PROCEDURE set_nombre(numero_cuenta VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_saldo(saldo DEC DEFAULT NULL),
    
    MEMBER FUNCTION get_id_banco RETURN VARCHAR2,
    MEMBER FUNCTION get_nombre RETURN VARCHAR2,
    MEMBER FUNCTION get_saldo RETURN DEC
	);
/
CREATE OR REPLACE NONEDITIONABLE TYPE BODY "DANIELBRMDZ"."BANCO" 
IS
	CONSTRUCTOR FUNCTION banco
		RETURN SELF AS RESULT
	IS
	BEGIN
		RETURN;
	END;

	CONSTRUCTOR FUNCTION banco(id_banco VARCHAR2,nombre VARCHAR2,saldo	DEC)
	RETURN SELF AS RESULT
	IS
	BEGIN
		SELF.id_banco := id_banco;
        SELF.nombre  := nombre;	
        SELF.saldo := saldo;
		RETURN;
	END;
    MEMBER PROCEDURE set_id_banco(id_registro VARCHAR2)
    IS 
	BEGIN 
	SELF.id_banco := id_banco;
	END;
	MEMBER PROCEDURE set_nombre(numero_cuenta VARCHAR2)
      IS 
	BEGIN 
	SELF.nombre  := nombre;
	END;
    MEMBER PROCEDURE set_saldo(saldo DEC)
    IS 
	BEGIN 
	SELF.saldo := saldo;
	END;

    MEMBER FUNCTION get_id_banco RETURN VARCHAR2 IS
  BEGIN
    RETURN id_banco;
  END;
    MEMBER FUNCTION get_nombre RETURN VARCHAR2 IS
  BEGIN
    RETURN nombre;
  END;
    MEMBER FUNCTION get_saldo RETURN DEC IS
  BEGIN
    RETURN saldo;
  END;
END;

/
--------------------------------------------------------
--  DDL for Type MENSAJE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TYPE "DANIELBRMDZ"."MENSAJE" AS OBJECT(
	cod_mensaje VARCHAR2(1),
	descripcion	VARCHAR2(100),
	CONSTRUCTOR FUNCTION mensaje
		RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION mensaje(cod_mensaje VARCHAR2,descripcion VARCHAR2)
		RETURN SELF AS RESULT,
    --SETS
	MEMBER PROCEDURE set_cod_mensaje(cod_mensaje VARCHAR2 DEFAULT NULL),
	MEMBER PROCEDURE set_descripcion(descripcion VARCHAR2 DEFAULT NULL),
    --GETS
    MEMBER FUNCTION get_cod_mensaje RETURN VARCHAR2,
    MEMBER FUNCTION get_descripcion RETURN VARCHAR2
	);
/
CREATE OR REPLACE NONEDITIONABLE TYPE BODY "DANIELBRMDZ"."MENSAJE" 
IS
	CONSTRUCTOR FUNCTION mensaje
		RETURN SELF AS RESULT
	IS
	BEGIN
		RETURN;
	END;

	CONSTRUCTOR FUNCTION mensaje(cod_mensaje VARCHAR2,descripcion VARCHAR2)
	RETURN SELF AS RESULT
	IS
	BEGIN
		SELF.cod_mensaje := cod_mensaje;
        SELF.descripcion  := descripcion;	
		RETURN;
	END;
    MEMBER PROCEDURE set_cod_mensaje(cod_mensaje VARCHAR2)
    IS 
	BEGIN 
	SELF.cod_mensaje := cod_mensaje;
	END;
	MEMBER PROCEDURE set_descripcion(descripcion VARCHAR2)
      IS 
	BEGIN 
	SELF.descripcion  := descripcion;	
	END;

    MEMBER FUNCTION get_cod_mensaje RETURN VARCHAR2 IS
  BEGIN
    RETURN cod_mensaje;
  END;
    MEMBER FUNCTION get_descripcion RETURN VARCHAR2 IS
  BEGIN
    RETURN descripcion;
  END;
END;

/
--------------------------------------------------------
--  DDL for Type REGISTRO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TYPE "DANIELBRMDZ"."REGISTRO" AS OBJECT(
	id_registro VARCHAR2(12),
    id_cliente VARCHAR2(5),
	numero_cuenta	VARCHAR2(12),
    id_banco VARCHAR2(3),
    monto	DEC(12,2),
    divisa	VARCHAR2(3),
    tipo	VARCHAR2(7),
	CONSTRUCTOR FUNCTION registro
		RETURN SELF AS RESULT,
	CONSTRUCTOR FUNCTION registro(id_registro VARCHAR2,id_cliente VARCHAR2,numero_cuenta VARCHAR2,id_banco VARCHAR2,monto	DEC,divisa	VARCHAR2,tipo VARCHAR2)
		RETURN SELF AS RESULT,
    --SETS
	MEMBER PROCEDURE set_id_registro(id_registro VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_id_cliente(id_cliente VARCHAR2 DEFAULT NULL),
	MEMBER PROCEDURE set_numero_cuenta(numero_cuenta VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_id_banco(id_banco VARCHAR2 DEFAULT NULL),
    MEMBER PROCEDURE set_monto(monto DEC DEFAULT NULL),
	MEMBER PROCEDURE set_divisa(divisa VARCHAR2 DEFAULT NULL),
	MEMBER PROCEDURE set_tipo(tipo VARCHAR2 DEFAULT NULL),
    --GETS
    MEMBER FUNCTION get_id_registro RETURN VARCHAR2,
    MEMBER FUNCTION get_id_cliente RETURN VARCHAR2,
    MEMBER FUNCTION get_numero_cuenta RETURN VARCHAR2,
    MEMBER FUNCTION get_id_banco RETURN VARCHAR2,
    MEMBER FUNCTION get_monto RETURN DEC,
    MEMBER FUNCTION get_divisa RETURN VARCHAR2,
    MEMBER FUNCTION get_tipo RETURN VARCHAR2
	);
/
CREATE OR REPLACE NONEDITIONABLE TYPE BODY "DANIELBRMDZ"."REGISTRO" 
IS
	CONSTRUCTOR FUNCTION registro
		RETURN SELF AS RESULT
	IS
	BEGIN
		RETURN;
	END;

	CONSTRUCTOR FUNCTION registro(id_registro VARCHAR2,id_cliente VARCHAR2,numero_cuenta VARCHAR2,id_banco VARCHAR2,monto	DEC,divisa	VARCHAR2,tipo VARCHAR2)
	RETURN SELF AS RESULT
	IS
	BEGIN
		SELF.id_registro := id_registro;
        SELF.id_cliente := id_cliente;
        SELF.numero_cuenta  := numero_cuenta;	
        SELF.id_banco  := id_banco;
        SELF.monto := monto;
        SELF.divisa  := divisa;	
        SELF.tipo := tipo;
		RETURN;
	END;
    MEMBER PROCEDURE set_id_registro(id_registro VARCHAR2)
    IS 
	BEGIN 
	SELF.id_registro := id_registro;
	END;
     MEMBER PROCEDURE set_id_cliente(id_cliente VARCHAR2)
    IS 
	BEGIN 
	SELF.id_cliente := id_cliente;
	END;
	MEMBER PROCEDURE set_numero_cuenta(numero_cuenta VARCHAR2)
      IS 
	BEGIN 
	SELF.numero_cuenta  := numero_cuenta;	
	END;
    MEMBER PROCEDURE set_id_banco(id_banco VARCHAR2)
      IS 
	BEGIN 
	SELF.id_banco  := id_banco;	
	END;
    MEMBER PROCEDURE set_monto(monto DEC)
    IS 
	BEGIN 
	SELF.monto := monto;
	END;
	MEMBER PROCEDURE set_divisa(divisa VARCHAR2)
      IS 
	BEGIN 
	SELF.divisa  := divisa;	
	END;
    MEMBER PROCEDURE set_tipo(tipo VARCHAR2) 
    IS 
	BEGIN 
	SELF.tipo := tipo;   
	END;

    MEMBER FUNCTION get_id_registro RETURN VARCHAR2 IS
  BEGIN
    RETURN id_registro;
  END;
   MEMBER FUNCTION get_id_cliente RETURN VARCHAR2 IS
  BEGIN
    RETURN id_cliente;
  END;
    MEMBER FUNCTION get_numero_cuenta RETURN VARCHAR2 IS
  BEGIN
    RETURN numero_cuenta;
  END;
    MEMBER FUNCTION get_id_banco RETURN VARCHAR2 IS
  BEGIN
    RETURN id_banco;
  END;
    MEMBER FUNCTION get_monto RETURN DEC IS
  BEGIN
    RETURN monto;
  END;
    MEMBER FUNCTION get_divisa RETURN VARCHAR2 IS
  BEGIN
    RETURN divisa;
  END;
    MEMBER FUNCTION get_tipo RETURN VARCHAR2 IS
  BEGIN
    RETURN tipo;
  END;
END;

/
--------------------------------------------------------
--  DDL for Table BANCO_TAB
--------------------------------------------------------

  CREATE TABLE "DANIELBRMDZ"."BANCO_TAB" SHARING=METADATA OF "DANIELBRMDZ"."BANCO" 
 OIDINDEX  ( PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ) 
 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CLIENTE_TAB
--------------------------------------------------------

  CREATE TABLE "DANIELBRMDZ"."CLIENTE_TAB" SHARING=METADATA OF "DANIELBRMDZ"."CLIENTE" 
 OIDINDEX  ( PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS" ) 
 SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" 
 VARRAY "LISTA_CUENTAS" STORE AS SECUREFILE LOB 
  ( TABLESPACE "USERS" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  CACHE  NOCOMPRESS  KEEP_DUPLICATES ) ;
--------------------------------------------------------
--  DDL for Table MENSAJE_TAB
--------------------------------------------------------

  CREATE TABLE "DANIELBRMDZ"."MENSAJE_TAB" SHARING=METADATA OF "DANIELBRMDZ"."MENSAJE" 
 OIDINDEX  ( PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ) 
 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table REGISTRO_TAB
--------------------------------------------------------

  CREATE TABLE "DANIELBRMDZ"."REGISTRO_TAB" SHARING=METADATA OF "DANIELBRMDZ"."REGISTRO" 
 OIDINDEX  ( PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS" ) 
 SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table TRANSACCION_TAB
--------------------------------------------------------

  CREATE TABLE "DANIELBRMDZ"."TRANSACCION_TAB" SHARING=METADATA OF "DANIELBRMDZ"."TRANSACCION" 
 OIDINDEX  ( PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS" ) 
 SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
REM INSERTING into DANIELBRMDZ.BANCO_TAB
SET DEFINE OFF;
Insert into DANIELBRMDZ.BANCO_TAB (ID_BANCO,NOMBRE,SALDO) values ('002','BANCO 2','0');
Insert into DANIELBRMDZ.BANCO_TAB (ID_BANCO,NOMBRE,SALDO) values ('003','BANCO 3','0');
Insert into DANIELBRMDZ.BANCO_TAB (ID_BANCO,NOMBRE,SALDO) values ('004','BANCO 4','0');
Insert into DANIELBRMDZ.BANCO_TAB (ID_BANCO,NOMBRE,SALDO) values ('005','BANCO 5','0');
Insert into DANIELBRMDZ.BANCO_TAB (ID_BANCO,NOMBRE,SALDO) values ('006','BANCO 6','0');
Insert into DANIELBRMDZ.BANCO_TAB (ID_BANCO,NOMBRE,SALDO) values ('007','BANCO 7','0');
Insert into DANIELBRMDZ.BANCO_TAB (ID_BANCO,NOMBRE,SALDO) values ('008','BANCO 8','0');
REM INSERTING into DANIELBRMDZ.CLIENTE_TAB
SET DEFINE OFF;
Insert into DANIELBRMDZ.CLIENTE_TAB (ID_CLIENTE,NOMBRES,APELLIDOS,FECHA_NACIMIENTO,TIPO_DOCUMENTO,NUMERO_DOCUMENTO,DIRECCION,ESTADO_CLIENTE,LISTA_CUENTAS) values ('00002','JUAN','ACERO',to_date('06/01/00','DD/MM/RR'),'CC','1010082269','transversal 16a','A',DANIELBRMDZ.CUENTAS(DANIELBRMDZ.CUENTA('001000002', 'COP', 43400000, 12500000, '2022-03-22 01:33:30.0', 'AHR', DANIELBRMDZ.BENEFICIARIOS(DANIELBRMDZ.BENEFICIARIO('00001', 'jose', '001000001', 'CC', '101010', '003')))));
Insert into DANIELBRMDZ.CLIENTE_TAB (ID_CLIENTE,NOMBRES,APELLIDOS,FECHA_NACIMIENTO,TIPO_DOCUMENTO,NUMERO_DOCUMENTO,DIRECCION,ESTADO_CLIENTE,LISTA_CUENTAS) values ('00001','Daniel','Bermudez Morales',to_date('06/01/00','DD/MM/RR'),'CC','1010082269','transversal 16a','A',DANIELBRMDZ.CUENTAS(DANIELBRMDZ.CUENTA('001000001', 'COP', 6650000, 1662500, '2022-03-22 01:34:21.0', 'PRE'DANIELBRMDZ.BENEFICIARIOS())));
REM INSERTING into DANIELBRMDZ.MENSAJE_TAB
SET DEFINE OFF;
Insert into DANIELBRMDZ.MENSAJE_TAB (COD_MENSAJE,DESCRIPCION) values ('0','Transaccion Realizada');
Insert into DANIELBRMDZ.MENSAJE_TAB (COD_MENSAJE,DESCRIPCION) values ('1','El banco no existe');
Insert into DANIELBRMDZ.MENSAJE_TAB (COD_MENSAJE,DESCRIPCION) values ('2','La cuenta no existe en el banco beneficiario');
Insert into DANIELBRMDZ.MENSAJE_TAB (COD_MENSAJE,DESCRIPCION) values ('3','La cuenta receptora se encuentra en otra divisa');
Insert into DANIELBRMDZ.MENSAJE_TAB (COD_MENSAJE,DESCRIPCION) values ('4','Faltan datos necesarios para efectuar la transacci�n');
Insert into DANIELBRMDZ.MENSAJE_TAB (COD_MENSAJE,DESCRIPCION) values ('5','Transaccion en proceso');
REM INSERTING into DANIELBRMDZ.REGISTRO_TAB
SET DEFINE OFF;
REM INSERTING into DANIELBRMDZ.TRANSACCION_TAB
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index SYS_C008396
--------------------------------------------------------

  CREATE UNIQUE INDEX "DANIELBRMDZ"."SYS_C008396" ON "DANIELBRMDZ"."BANCO_TAB" ("ID_BANCO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C008397
--------------------------------------------------------

  CREATE UNIQUE INDEX "DANIELBRMDZ"."SYS_C008397" ON "DANIELBRMDZ"."BANCO_TAB" ("SYS_NC_OID$") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C008389
--------------------------------------------------------

  CREATE UNIQUE INDEX "DANIELBRMDZ"."SYS_C008389" ON "DANIELBRMDZ"."CLIENTE_TAB" ("ID_CLIENTE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C008390
--------------------------------------------------------

  CREATE UNIQUE INDEX "DANIELBRMDZ"."SYS_C008390" ON "DANIELBRMDZ"."CLIENTE_TAB" ("SYS_NC_OID$") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C008393
--------------------------------------------------------

  CREATE UNIQUE INDEX "DANIELBRMDZ"."SYS_C008393" ON "DANIELBRMDZ"."MENSAJE_TAB" ("COD_MENSAJE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C008394
--------------------------------------------------------

  CREATE UNIQUE INDEX "DANIELBRMDZ"."SYS_C008394" ON "DANIELBRMDZ"."MENSAJE_TAB" ("SYS_NC_OID$") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C008395
--------------------------------------------------------

  CREATE UNIQUE INDEX "DANIELBRMDZ"."SYS_C008395" ON "DANIELBRMDZ"."REGISTRO_TAB" ("SYS_NC_OID$") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C008391
--------------------------------------------------------

  CREATE UNIQUE INDEX "DANIELBRMDZ"."SYS_C008391" ON "DANIELBRMDZ"."TRANSACCION_TAB" ("ID_TRANSACCION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C008392
--------------------------------------------------------

  CREATE UNIQUE INDEX "DANIELBRMDZ"."SYS_C008392" ON "DANIELBRMDZ"."TRANSACCION_TAB" ("SYS_NC_OID$") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Procedure ADD_BENEFICIARIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "DANIELBRMDZ"."ADD_BENEFICIARIO" ( 
    id_beneficiario VARCHAR2,
    numero_cuenta VARCHAR2,
    cliente_id  VARCHAR2,
	nombre	VARCHAR2,
	cuenta_asociada VARCHAR2,
	tipo_documento VARCHAR2,
    numero_documento VARCHAR2,
    id_banco VARCHAR)
IS
 cliente_aux  cliente;
 lst_cuentas cuentas;
 new_ben beneficiario;
BEGIN
   SELECT value(cl)
   INTO cliente_aux
   FROM cliente_tab cl
   WHERE cl.id_cliente = cliente_id;
   lst_cuentas := cuentas();
   lst_cuentas := cliente_aux.get_cuentas();
  FOR i IN lst_cuentas.FIRST .. lst_cuentas.LAST
  loop
      IF(lst_cuentas(i).numero_cuenta = numero_cuenta) THEN 
       new_ben := beneficiario(id_beneficiario ,nombre ,cuenta_asociada ,tipo_documento ,numero_documento , id_banco );
       lst_cuentas(i).add_beneficiario(new_ben);
       UPDATE cliente_tab set lista_cuentas = lst_cuentas where id_cliente = cliente_id;
      END IF;
  END LOOP;
END;

/
--------------------------------------------------------
--  DDL for Procedure ADD_CUENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "DANIELBRMDZ"."ADD_CUENTA" ( 
   numero_cuenta VARCHAR2,
   cliente_id  VARCHAR2,
   divisa VARCHAR2,
   saldo DEC)
IS
  cliente_aux  Cliente;
  new_cuenta Cuenta;
  lst_cuentas cuentas;
BEGIN
   SELECT value(cl)
   INTO cliente_aux
   FROM cliente_tab cl
   WHERE cl.id_cliente = cliente_id;
   new_cuenta := cuenta(numero_cuenta,divisa,saldo,SYSDATE);
   cliente_aux.add_cuenta(new_cuenta);
   lst_cuentas := cuentas();
   lst_cuentas := cliente_aux.get_cuentas();
   UPDATE cliente_tab set lista_cuentas = lst_cuentas where id_cliente = cliente_id;
END add_cuenta;

/
--------------------------------------------------------
--  DDL for Procedure CREDITO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "DANIELBRMDZ"."CREDITO" ( cliente_id  VARCHAR2, num_cuenta VARCHAR2, monto DEC)
IS
 cliente_aux  cliente;
 lsta_cuenta cuentas := cuentas();
 saldo_aux dec;
BEGIN
   SELECT value(cl)
   INTO cliente_aux
   FROM cliente_tab cl
   WHERE cl.id_cliente = cliente_id;
   lsta_cuenta := cliente_aux.get_cuentas();
    FOR i IN lsta_cuenta.FIRST .. lsta_cuenta.LAST
    LOOP
       IF(lsta_cuenta(i).numero_cuenta =  num_cuenta) THEN 
            saldo_aux := lsta_cuenta(i).get_saldo + monto;
            lsta_cuenta(i).set_saldo(saldo_aux);
            UPDATE cliente_tab set lista_cuentas = lsta_cuenta where id_cliente = cliente_id ;
       END IF;    
    END LOOP;
END credito;


/
--------------------------------------------------------
--  DDL for Procedure CREDITO_BANCO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "DANIELBRMDZ"."CREDITO_BANCO" ( banco_id  VARCHAR2, monto DEC)
IS
BEGIN
  UPDATE banco_tab set saldo = saldo + monto where id_banco = banco_id ;
END credito_banco;

/
--------------------------------------------------------
--  DDL for Procedure DEBITO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "DANIELBRMDZ"."DEBITO" (cliente_id  VARCHAR2, num_cuenta VARCHAR2 , monto DEC)
IS
 cliente_aux  cliente;
 lsta_cuenta cuentas := cuentas();
 saldo_aux dec;
BEGIN
   SELECT value(cl)
   INTO cliente_aux
   FROM cliente_tab cl
   WHERE cl.id_cliente = cliente_id;
   lsta_cuenta := cliente_aux.get_cuentas();
    FOR i IN lsta_cuenta.FIRST .. lsta_cuenta.LAST
    LOOP
       IF (lsta_cuenta(i).numero_cuenta =  num_cuenta) THEN 
            saldo_aux := lsta_cuenta(i).get_saldo - monto;
            lsta_cuenta(i).set_saldo(saldo_aux);
            UPDATE cliente_tab set lista_cuentas = lsta_cuenta where id_cliente = cliente_id ;
       END IF;    
    END LOOP;
END debito;

/
--------------------------------------------------------
--  DDL for Procedure DEBITO_BANCO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "DANIELBRMDZ"."DEBITO_BANCO" ( banco_id  VARCHAR2, monto DEC)
IS
BEGIN
  UPDATE banco_tab set saldo = saldo-monto where id_banco = banco_id ;
END debito_banco;

/
--------------------------------------------------------
--  DDL for Trigger T_TRANSACCION
--------------------------------------------------------

CREATE OR REPLACE NONEDITIONABLE TRIGGER "DANIELBRMDZ"."T_TRANSACCION" 
 after insert or update 
 on transaccion_tab
 FOR EACH ROW
 declare
 begin
 IF INSERTING THEN
  IF((:new.id_cliente <> '002') AND (:new.id_cliente <> '003') AND (:new.id_cliente <> '004') AND (:new.id_cliente <> '005')
        AND (:new.id_cliente <> '006') AND (:new.id_cliente <> '007') AND (:new.id_cliente <> '008')) THEN
        debito(:new.id_cliente,:new.numero_cuenta, :new.valor_transferencia);
  ELSE
        debito_banco(:new.id_cliente,:new.valor_transferencia);
  END IF;      
END IF;
 IF :new.estado_transaccion = '1' THEN
    IF((:new.id_cliente <> '002') AND (:new.id_cliente <> '003') AND (:new.id_cliente <> '004') AND (:new.id_cliente <> '005')
        AND (:new.id_cliente <> '006') AND (:new.id_cliente <> '007') AND (:new.id_cliente <> '008')) THEN
        INSERT INTO registro_tab VALUES (registro(:new.id_transaccion,:new.id_cliente,:new.numero_cuenta ,'001',:new.valor_transferencia	,:new.divisa,'debito' ));
        IF((:new.id_cliente_2 <> '002') AND (:new.id_cliente_2 <> '003') AND (:new.id_cliente_2 <> '004') AND (:new.id_cliente_2 <> '005')
            AND (:new.id_cliente_2 <> '006') AND (:new.id_cliente_2 <> '007') AND (:new.id_cliente_2 <> '008')) THEN
            INSERT INTO registro_tab VALUES (registro(:new.id_transaccion ,:new.id_cliente_2,:new.numero_cuenta_2 ,:new.id_banco ,:new.valor_transferencia	,:new.divisa,'credito' ));
            credito(:new.id_cliente_2,:new.numero_cuenta_2, :new.valor_transferencia);
        ELSE 
            INSERT INTO registro_tab VALUES (registro(:new.id_transaccion ,:new.id_cliente_2,:new.numero_cuenta_2 ,:new.id_banco ,:new.valor_transferencia	,:new.divisa,'credito' ));
            credito_banco(:new.id_cliente_2,:new.valor_transferencia);
        END IF;
    ELSE 
        INSERT INTO registro_tab VALUES (registro(:new.id_transaccion,:new.id_cliente,:new.numero_cuenta ,:new.id_banco,:new.valor_transferencia,:new.divisa,'debito' ));
        INSERT INTO registro_tab VALUES (registro(:new.id_transaccion ,:new.id_cliente_2,:new.numero_cuenta_2 ,'001' ,:new.valor_transferencia	,:new.divisa,'credito' ));
        credito(:new.id_cliente_2,:new.numero_cuenta_2, :new.valor_transferencia);
    END IF;
END IF;
IF :new.estado_transaccion = '3' THEN
     IF((:new.id_cliente <> '002') AND (:new.id_cliente <> '003') AND (:new.id_cliente <> '004') AND (:new.id_cliente <> '005')
        AND (:new.id_cliente <> '006') AND (:new.id_cliente <> '007') AND (:new.id_cliente <> '008')) THEN
        credito(:new.id_cliente,:new.numero_cuenta, :new.valor_transferencia);    
  ELSE
        credito_banco(:new.id_cliente,:new.valor_transferencia);
  END IF;      
END IF;
END t_transaccion;

/
ALTER TRIGGER "DANIELBRMDZ"."T_TRANSACCION" ENABLE;
--------------------------------------------------------
--  DDL for Procedure PR_SEND_PAYMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "DANIELBRMDZ"."PR_SEND_PAYMENT" (
	p_trace_key VARCHAR2,--(20),
	p_sender_bank VARCHAR2,--(3)
	p_sender_account VARCHAR2,--(18),
	p_amount NUMBER,
	p_currency VARCHAR2,--(3), DIVISAS EN FORMATO ISO-4217
	p_receiver_bank VARCHAR2,--(3),
	p_receiver_account VARCHAR2,--(18),
	p_date_time DATE
)
IS
cliente_id VARCHAR2(5);
BEGIN
SELECT e.id_cliente
INTO cliente_id
FROM cliente_tab E, TABLE(E.lista_cuentas) Emp 
where emp.numero_cuenta = p_sender_account;
INSERT INTO transaccion_tab VALUES (transaccion(p_trace_key,cliente_id,p_sender_account,p_receiver_bank,p_receiver_account,p_receiver_bank,p_amount,p_currency,p_date_time,'5','2'));
-- linea que llama al metodo de la capa media
HR.PR_SEND_PAYMENT(p_trace_key ,p_sender_bank,p_sender_account ,p_amount,p_currency,p_receiver_bank,p_receiver_account,p_date_time);
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_UPDATE_STATUS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "DANIELBRMDZ"."PR_UPDATE_STATUS" (
p_trace_key VARCHAR2,--(20),
p_date	DATE,
p_status VARCHAR2--(1));
)
IS
BEGIN
IF(p_status = '0') THEN
    UPDATE transaccion_tab
    SET estado_transaccion = '1' , fecha_transaccion = p_date, cod_mensaje = p_status
    WHERE id_transaccion = p_trace_key;
ELSE
    UPDATE transaccion_tab
    SET estado_transaccion = '3' , fecha_transaccion = p_date , cod_mensaje = p_status
    WHERE id_transaccion = p_trace_key;
END IF;
END;

/
--------------------------------------------------------
--  DDL for Function FN_RECEIVE_PAYMENT
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "DANIELBRMDZ"."FN_RECEIVE_PAYMENT" (
	p_trace_key VARCHAR2,--(20),
	p_sender_bank VARCHAR2,--(3)
	p_sender_account VARCHAR2,--(1
	p_amount NUMBER,
	p_currency VARCHAR2,--(3),DIVISAS EN FORMATO ISO-4217
	p_receiver_bank VARCHAR2,--(3),
	p_receiver_account VARCHAR2,--(18),
	p_date_time DATE
)
RETURN VARCHAR2 IS
	l_cause_of_return VARCHAR2(1) := 0;
    cliente_id VARCHAR2(5);
    banco_id  VARCHAR2(3);
    dvisa_cuenta  VARCHAR2(3);
BEGIN
    IF((p_trace_key IS NULL) OR (p_sender_bank IS NULL)  OR (p_sender_account IS NULL)  OR (p_amount IS NULL)  OR (p_currency IS NULL) 
       OR (p_receiver_bank IS NULL)  OR (p_receiver_account IS NULL)  OR (p_date_time IS NULL)) THEN
       l_cause_of_return := 4;
       RETURN l_cause_of_return;
    END IF;

    SELECT id_banco 
    INTO  banco_id
    FROM  banco_tab
    WHERE id_banco = p_sender_bank;

    SELECT e.id_cliente, EMP.divisa
    INTO cliente_id, dvisa_cuenta
    FROM cliente_tab E, TABLE(E.lista_cuentas) Emp 
    WHERE emp.numero_cuenta = p_receiver_account;

    IF(dvisa_cuenta <> p_currency) THEN
       l_cause_of_return := 3;
        RETURN l_cause_of_return; 
    END IF;

    INSERT INTO transaccion_tab VALUES (transaccion(p_trace_key,p_sender_bank,p_sender_account,cliente_id,p_receiver_account,p_receiver_bank,p_amount,p_currency,p_date_time,'01','1'));
    RETURN l_cause_of_return;
    EXCEPTION
    WHEN no_data_found THEN
    IF (banco_id IS NULL) THEN
        l_cause_of_return := 1;
       RETURN l_cause_of_return;
    END IF;
     IF(cliente_id IS NULL) THEN
       l_cause_of_return := 2;
        RETURN l_cause_of_return; 
    END IF;
END FN_RECEIVE_PAYMENT;
    --0 - Transacci�n Realizada
	--1 - El banco no existe.
	--2 - La cuenta no existe en el banco beneficiario.
	--3 - La cuenta receptora se encuentra en otra divisa.
	--4 - Faltan datos necesarios para efectuar la transacci�n.

/
--------------------------------------------------------
--  Constraints for Table BANCO_TAB
--------------------------------------------------------

  ALTER TABLE "DANIELBRMDZ"."BANCO_TAB" ADD PRIMARY KEY ("ID_BANCO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DANIELBRMDZ"."BANCO_TAB" ADD UNIQUE ("SYS_NC_OID$") RELY
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CLIENTE_TAB
--------------------------------------------------------

  ALTER TABLE "DANIELBRMDZ"."CLIENTE_TAB" ADD PRIMARY KEY ("ID_CLIENTE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DANIELBRMDZ"."CLIENTE_TAB" ADD UNIQUE ("SYS_NC_OID$") RELY
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table MENSAJE_TAB
--------------------------------------------------------

  ALTER TABLE "DANIELBRMDZ"."MENSAJE_TAB" ADD PRIMARY KEY ("COD_MENSAJE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DANIELBRMDZ"."MENSAJE_TAB" ADD UNIQUE ("SYS_NC_OID$") RELY
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table REGISTRO_TAB
--------------------------------------------------------

  ALTER TABLE "DANIELBRMDZ"."REGISTRO_TAB" ADD UNIQUE ("SYS_NC_OID$") RELY
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table TRANSACCION_TAB
--------------------------------------------------------

  ALTER TABLE "DANIELBRMDZ"."TRANSACCION_TAB" ADD PRIMARY KEY ("ID_TRANSACCION")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DANIELBRMDZ"."TRANSACCION_TAB" ADD UNIQUE ("SYS_NC_OID$") RELY
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE;
