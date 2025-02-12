PGDMP  "                    |            santafe    16.2 (Debian 16.2-1.pgdg120+2)    16.2 =    |           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            }           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ~           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16388    santafe    DATABASE     r   CREATE DATABASE santafe WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE santafe;
                postgres    false            �           0    0    SCHEMA public    ACL     *   GRANT ALL ON SCHEMA public TO vespidboss;
                   pg_database_owner    false    5            �            1255    24686 5   p_insertar_actualizar_aportes(date, double precision) 	   PROCEDURE     �  CREATE PROCEDURE public.p_insertar_actualizar_aportes(IN l_fecha date, IN l_aportes double precision)
    LANGUAGE plpgsql
    AS $$
declare
    l_total_registros    int :=0;

begin
    --Aqui validamos si hay registros con la misma fecha
    select count(fecha) into l_total_registros
    from aportes a
    where a.fecha = l_fecha;

    -- Si hay registro, se actualiza el valor y fecha
        if(l_total_registros>0) then
    --Actualización
    update aportes a
    set fecha = l_fecha,
        aportes = l_aportes     
    where a.fecha = l_fecha;
    -- de lo contrario, se inserta
    else
        insert into aportes (
            fecha,
		    aportes)
        values
        (l_fecha,
         l_aportes);

    end if;
end;
$$;
 e   DROP PROCEDURE public.p_insertar_actualizar_aportes(IN l_fecha date, IN l_aportes double precision);
       public       
   vespidboss    false            �            1255    24701 �   p_insertar_actualizar_combustibles(date, double precision, double precision, double precision, double precision, double precision) 	   PROCEDURE     D  CREATE PROCEDURE public.p_insertar_actualizar_combustibles(IN l_fecha date, IN l_solar double precision, IN l_agua double precision, IN l_carbon double precision, IN l_glp double precision, IN l_gas_natural double precision)
    LANGUAGE plpgsql
    AS $$
declare
    l_total_registros    int :=0;

begin
    --Aqui validamos si hay registros con la misma fecha
    select count(fecha) into l_total_registros
    from combustibles c
    where c.fecha = l_fecha;

    -- Si hay registro, se actualiza el valor y fecha
        if(l_total_registros>0) then
    --Actualización
    update combustibles c
    set fecha = l_fecha,
        solar = l_solar,
	    agua = l_agua,
	    carbon = l_carbon,
	    glp = l_glp,
	    gas_natural = l_gas_natural
    where c.fecha = l_fecha;
    -- de lo contrario, se inserta
    else
        insert into combustibles (
            fecha,
		    solar,
	        agua,
	        carbon,
	        glp,
	        gas_natural)
        values
        (l_fecha,
         l_solar,
	     l_agua,
	     l_carbon,
	     l_glp,
	     l_gas_natural);

    end if;
end;
$$;
 �   DROP PROCEDURE public.p_insertar_actualizar_combustibles(IN l_fecha date, IN l_solar double precision, IN l_agua double precision, IN l_carbon double precision, IN l_glp double precision, IN l_gas_natural double precision);
       public       
   vespidboss    false            �            1255    24688 5   p_insertar_actualizar_demanda(date, double precision) 	   PROCEDURE     �  CREATE PROCEDURE public.p_insertar_actualizar_demanda(IN l_fecha date, IN l_demanda double precision)
    LANGUAGE plpgsql
    AS $$
declare
    l_total_registros    int :=0;

begin
    --Aqui validamos si hay registros con la misma fecha
    select count(fecha) into l_total_registros
    from demanda d
    where d.fecha = l_fecha;

    -- Si hay registro, se actualiza el valor y fecha
        if(l_total_registros>0) then
    --Actualización
    update demanda d
    set fecha = l_fecha,
        demanda = l_demanda      
    where d.fecha = l_fecha;
    -- de lo contrario, se inserta
    else
        insert into demanda (
            fecha,
		    demanda)
        values
        (l_fecha,
         l_demanda);

    end if;
end;
$$;
 e   DROP PROCEDURE public.p_insertar_actualizar_demanda(IN l_fecha date, IN l_demanda double precision);
       public       
   vespidboss    false            �            1255    24713 E   p_insertar_actualizar_exposicion(character varying, double precision) 	   PROCEDURE       CREATE PROCEDURE public.p_insertar_actualizar_exposicion(IN l_sic character varying, IN l_exposicion double precision)
    LANGUAGE plpgsql
    AS $$
declare
    l_total_registros    int :=0;

begin
    --Aqui validamos si hay registros con el mismo codigo
    select count(sic) into l_total_registros
    from  agentes_exposicion a
    where a.sic = l_sic;

    -- Si hay registro, se actualiza el valor 
        if(l_total_registros>0) then
    --Actualización
    update agentes_exposicion a
    set sic = l_sic,
        exposicion = l_exposicion      
    where a.sic = l_sic;
    -- de lo contrario, se inserta
    else
        insert into agentes_exposicion (
            sic,
		    exposicion)
        values
        (l_sic,
         l_exposicion);

    end if;
end;
$$;
 v   DROP PROCEDURE public.p_insertar_actualizar_exposicion(IN l_sic character varying, IN l_exposicion double precision);
       public       
   vespidboss    false            �            1255    24687 8   p_insertar_actualizar_generacion(date, double precision) 	   PROCEDURE     �  CREATE PROCEDURE public.p_insertar_actualizar_generacion(IN l_fecha date, IN l_gene_real double precision)
    LANGUAGE plpgsql
    AS $$
declare
    l_total_registros    int :=0;

begin
    --Aqui validamos si hay registros con la misma fecha
    select count(fecha) into l_total_registros
    from gene_real g
    where g.fecha = l_fecha;

    -- Si hay registro, se actualiza el valor y fecha
        if(l_total_registros>0) then
    --Actualización
    update gene_real g
    set fecha = l_fecha,
        gene_real = l_gene_real      
    where g.fecha = l_fecha;
    -- de lo contrario, se inserta
    else
        insert into gene_real (
            fecha,
		    gene_real)
        values
        (l_fecha,
         l_gene_real);

    end if;
end;
$$;
 j   DROP PROCEDURE public.p_insertar_actualizar_generacion(IN l_fecha date, IN l_gene_real double precision);
       public       
   vespidboss    false            �            1255    24695 G   p_insertar_actualizar_generacion_hidroelectrica(date, double precision) 	   PROCEDURE       CREATE PROCEDURE public.p_insertar_actualizar_generacion_hidroelectrica(IN l_fecha date, IN l_gene_hidro double precision)
    LANGUAGE plpgsql
    AS $$
declare
    l_total_registros    int :=0;

begin
    --Aqui validamos si hay registros con la misma fecha
    select count(fecha) into l_total_registros
    from gene_hidro g
    where g.fecha = l_fecha;

    -- Si hay registro, se actualiza el valor y fecha
        if(l_total_registros>0) then
    --Actualización
    update gene_hidro g
    set fecha = l_fecha,
        gene_hidro = l_gene_hidro      
    where g.fecha = l_fecha;
    -- de lo contrario, se inserta
    else
        insert into gene_hidro (
            fecha,
		    gene_hidro)
        values
        (l_fecha,
         l_gene_hidro);

    end if;
end;
$$;
 z   DROP PROCEDURE public.p_insertar_actualizar_generacion_hidroelectrica(IN l_fecha date, IN l_gene_hidro double precision);
       public       
   vespidboss    false            �            1255    24694 @   p_insertar_actualizar_generacion_termica(date, double precision) 	   PROCEDURE       CREATE PROCEDURE public.p_insertar_actualizar_generacion_termica(IN l_fecha date, IN l_gene_termica double precision)
    LANGUAGE plpgsql
    AS $$
declare
    l_total_registros    int :=0;

begin
    --Aqui validamos si hay registros con la misma fecha
    select count(fecha) into l_total_registros
    from gene_termica g
    where g.fecha = l_fecha;

    -- Si hay registro, se actualiza el valor y fecha
        if(l_total_registros>0) then
    --Actualización
    update gene_termica g
    set fecha = l_fecha,
        gene_termica = l_gene_termica      
    where g.fecha = l_fecha;
    -- de lo contrario, se inserta
    else
        insert into gene_termica (
            fecha,
		    gene_termica)
        values
        (l_fecha,
         l_gene_termica);

    end if;
end;
$$;
 u   DROP PROCEDURE public.p_insertar_actualizar_generacion_termica(IN l_fecha date, IN l_gene_termica double precision);
       public       
   vespidboss    false            �            1255    24693 @   p_insertar_actualizar_porcentaje_aportes(date, double precision) 	   PROCEDURE       CREATE PROCEDURE public.p_insertar_actualizar_porcentaje_aportes(IN l_fecha date, IN l_por_aportes double precision)
    LANGUAGE plpgsql
    AS $$
declare
    l_total_registros    int :=0;

begin
    --Aqui validamos si hay registros con la misma fecha
    select count(fecha) into l_total_registros
    from por_aportes p
    where p.fecha = l_fecha;

    -- Si hay registro, se actualiza el valor y fecha
        if(l_total_registros>0) then
    --Actualización
    update por_aportes p
    set fecha = l_fecha,
        por_aportes = l_por_aportes      
    where p.fecha = l_fecha;
    -- de lo contrario, se inserta
    else
        insert into por_aportes (
            fecha,
		    por_aportes)
        values
        (l_fecha,
         l_por_aportes);

    end if;
end;
$$;
 t   DROP PROCEDURE public.p_insertar_actualizar_porcentaje_aportes(IN l_fecha date, IN l_por_aportes double precision);
       public       
   vespidboss    false            �            1255    16397 :   p_insertar_actualizar_precio_bolsa(date, double precision) 	   PROCEDURE     �  CREATE PROCEDURE public.p_insertar_actualizar_precio_bolsa(IN l_fecha date, IN l_precio double precision)
    LANGUAGE plpgsql
    AS $$
declare
	l_total_registros    int :=0;

begin

    --Aqui validamos si hay registros con la misma fecha del precio
    select count(fecha) into l_total_registros
    from precios_bolsa p
    where p.fecha = l_fecha;

    -- Si hay registro, se actualiza el valor y fecha
    if(l_total_registros>0) then
    --Actualización
    update precios_bolsa p
    set fecha = l_fecha,
        precio = l_precio      
    where p.fecha = l_fecha;
    -- de lo contrario, se inserta
    else
        insert into precios_bolsa (
            fecha,
		    precio)
        values
        (l_fecha,
         l_precio);

    end if;
end;
$$;
 i   DROP PROCEDURE public.p_insertar_actualizar_precio_bolsa(IN l_fecha date, IN l_precio double precision);
       public       
   vespidboss    false            �            1255    24689 :   p_insertar_actualizar_volumen_util(date, double precision) 	   PROCEDURE     �  CREATE PROCEDURE public.p_insertar_actualizar_volumen_util(IN l_fecha date, IN l_vol_util double precision)
    LANGUAGE plpgsql
    AS $$
declare
    l_total_registros    int :=0;

begin
    --Aqui validamos si hay registros con la misma fecha
    select count(fecha) into l_total_registros
    from volumen_util v
    where v.fecha = l_fecha;

    -- Si hay registro, se actualiza el valor y fecha
        if(l_total_registros>0) then
    --Actualización
    update volumen_util v
    set fecha = l_fecha,
        vol_util = l_vol_util      
    where v.fecha = l_fecha;
    -- de lo contrario, se inserta
    else
        insert into volumen_util (
            fecha,
		    vol_util)
        values
        (l_fecha,
         l_vol_util);

    end if;
end;
$$;
 k   DROP PROCEDURE public.p_insertar_actualizar_volumen_util(IN l_fecha date, IN l_vol_util double precision);
       public       
   vespidboss    false            �            1255    24629 B   p_insertar_convo(character varying, character varying, date, date) 	   PROCEDURE     �  CREATE PROCEDURE public.p_insertar_convo(IN p_codigo character varying, IN p_agente character varying, IN p_fecha_ofertas date, IN p_fecha_audiencia date)
    LANGUAGE plpgsql
    AS $$
declare
	l_total_registros    int :=0;

begin

    --Aqui validamos si hay registros con la mismo id
    select count(p_codigo) into l_total_registros
    from convocatorias c
    where c.codigo = p_codigo;

    -- Si hay registro, se actualiza 
    if(l_total_registros>0) then
    --Actualización
    update convocatorias c
    set codigo = p_codigo,
        agente = p_agente,
		fecha_ofertas = p_fecha_ofertas,
		fecha_audiencia= p_fecha_audiencia
    where c.codigo = p_codigo;
    -- de lo contrario, se inserta
    else
        insert into convocatorias (
            codigo,
		    agente,
		    fecha_ofertas,
		    fecha_audiencia)
        values
        (p_codigo,
         p_agente,
		 p_fecha_ofertas ,
		 p_fecha_audiencia);

    end if;
end;
$$;
 �   DROP PROCEDURE public.p_insertar_convo(IN p_codigo character varying, IN p_agente character varying, IN p_fecha_ofertas date, IN p_fecha_audiencia date);
       public       
   vespidboss    false            �            1255    24631 o   p_insertar_producto(character varying, double precision, double precision, character varying, double precision) 	   PROCEDURE     /  CREATE PROCEDURE public.p_insertar_producto(IN p_codigo character varying, IN p_precio_reserva double precision, IN p_energia double precision, IN p_conovatoria character varying, IN p_precio_prom double precision)
    LANGUAGE plpgsql
    AS $$
declare
	l_total_registros int :=0;

begin

    --Aqui validamos si hay registros con la mismo id
    select count(p_codigo) into l_total_registros
    from productos p
    where p.codigo = p_codigo;

    -- Si hay registro, se actualiza 
    if(l_total_registros>0) then
    --Actualización
    update productos p
    set codigo = p_codigo,
        precio_reserva = p_precio_reserva,
		energia = p_energia,
		convocatoria= p_conovatoria,
	    precio_promedio = p_precio_prom
	    
    where p.codigo = p_codigo;
    -- de lo contrario, se inserta
    else
        insert into productos (
            codigo,
		    precio_reserva,
		    energia,
		    convocatoria,
		    precio_promedio)
        values
        (p_codigo,
         p_precio_reserva,
		 p_energia ,
		 p_conovatoria,
		 p_precio_prom);

    end if;
end;
$$;
 �   DROP PROCEDURE public.p_insertar_producto(IN p_codigo character varying, IN p_precio_reserva double precision, IN p_energia double precision, IN p_conovatoria character varying, IN p_precio_prom double precision);
       public       
   vespidboss    false            �            1255    24630 4   p_insertar_producto_año(character varying, integer) 	   PROCEDURE     )  CREATE PROCEDURE public."p_insertar_producto_año"(IN p_codigo_prod character varying, IN p_ano integer)
    LANGUAGE plpgsql
    AS $$
declare
	l_total_registros    int :=0;

begin

    --Aqui validamos si hay registros con la mismo id
    select count(p_codigo_prod) into l_total_registros
    from anos_productos p
    where p.codigo_prod = p_codigo_prod and p.ano = p_ano;

    -- Si hay registro, se actualiza 
    if(l_total_registros>0) then
    --Actualización
    update anos_productos p
    set codigo_prod = p_codigo_prod,
        ano = p_ano
    where p.codigo_prod = p_codigo_prod and p.ano = p_ano;
    -- de lo contrario, se inserta
    else
        insert into anos_productos (
            codigo_prod,
		    ano)
        values
        (p_codigo_prod,
         p_ano);

    end if;
end;
$$;
 h   DROP PROCEDURE public."p_insertar_producto_año"(IN p_codigo_prod character varying, IN p_ano integer);
       public       
   vespidboss    false            �            1259    24576    agentes    TABLE     �   CREATE TABLE public.agentes (
    sic character varying(20) NOT NULL,
    nombre character varying(200),
    tipo character varying(20)
);
    DROP TABLE public.agentes;
       public         heap 
   vespidboss    false            �            1259    24702    agentes_exposicion    TABLE     }   CREATE TABLE public.agentes_exposicion (
    sic character varying(10) NOT NULL,
    exposicion double precision NOT NULL
);
 &   DROP TABLE public.agentes_exposicion;
       public         heap 
   vespidboss    false            �            1259    24601    anos_productos    TABLE     q   CREATE TABLE public.anos_productos (
    codigo_prod character varying(40) NOT NULL,
    ano integer NOT NULL
);
 "   DROP TABLE public.anos_productos;
       public         heap 
   vespidboss    false            �            1259    24668    aportes    TABLE     `   CREATE TABLE public.aportes (
    fecha date NOT NULL,
    aportes double precision NOT NULL
);
    DROP TABLE public.aportes;
       public         heap 
   vespidboss    false            �            1259    24696    combustibles    TABLE     �   CREATE TABLE public.combustibles (
    fecha date NOT NULL,
    solar double precision NOT NULL,
    agua double precision NOT NULL,
    carbon double precision NOT NULL,
    glp double precision NOT NULL,
    gas_natural double precision NOT NULL
);
     DROP TABLE public.combustibles;
       public         heap 
   vespidboss    false            �            1259    24581    convocatorias    TABLE     �   CREATE TABLE public.convocatorias (
    codigo character varying(20) NOT NULL,
    agente character varying(20) NOT NULL,
    fecha_ofertas timestamp without time zone NOT NULL,
    fecha_audiencia timestamp without time zone NOT NULL
);
 !   DROP TABLE public.convocatorias;
       public         heap 
   vespidboss    false            �            1259    24665    demanda    TABLE     `   CREATE TABLE public.demanda (
    fecha date NOT NULL,
    demanda double precision NOT NULL
);
    DROP TABLE public.demanda;
       public         heap 
   vespidboss    false            �            1259    24677 
   gene_hidro    TABLE     f   CREATE TABLE public.gene_hidro (
    fecha date NOT NULL,
    gene_hidro double precision NOT NULL
);
    DROP TABLE public.gene_hidro;
       public         heap 
   vespidboss    false            �            1259    24671 	   gene_real    TABLE     d   CREATE TABLE public.gene_real (
    fecha date NOT NULL,
    gene_real double precision NOT NULL
);
    DROP TABLE public.gene_real;
       public         heap 
   vespidboss    false            �            1259    24674    gene_termica    TABLE     j   CREATE TABLE public.gene_termica (
    fecha date NOT NULL,
    gene_termica double precision NOT NULL
);
     DROP TABLE public.gene_termica;
       public         heap 
   vespidboss    false            �            1259    24611    ofertas_productos    TABLE     �   CREATE TABLE public.ofertas_productos (
    codigo_prod character varying(40) NOT NULL,
    agente character varying(20) NOT NULL,
    precio double precision NOT NULL,
    adjudico boolean NOT NULL
);
 %   DROP TABLE public.ofertas_productos;
       public         heap 
   vespidboss    false            �            1259    24690    por_aportes    TABLE     h   CREATE TABLE public.por_aportes (
    fecha date NOT NULL,
    por_aportes double precision NOT NULL
);
    DROP TABLE public.por_aportes;
       public         heap 
   vespidboss    false            �            1259    16390    precios_bolsa    TABLE     e   CREATE TABLE public.precios_bolsa (
    fecha date NOT NULL,
    precio double precision NOT NULL
);
 !   DROP TABLE public.precios_bolsa;
       public         heap 
   vespidboss    false            �            1259    24591 	   productos    TABLE       CREATE TABLE public.productos (
    codigo character varying(40) NOT NULL,
    precio_reserva double precision NOT NULL,
    energia double precision NOT NULL,
    convocatoria character varying(40) NOT NULL,
    precio_promedio double precision NOT NULL
);
    DROP TABLE public.productos;
       public         heap 
   vespidboss    false            �            1259    24680    volumen_util    TABLE     f   CREATE TABLE public.volumen_util (
    fecha date NOT NULL,
    vol_util double precision NOT NULL
);
     DROP TABLE public.volumen_util;
       public         heap 
   vespidboss    false            l          0    24576    agentes 
   TABLE DATA           4   COPY public.agentes (sic, nombre, tipo) FROM stdin;
    public       
   vespidboss    false    216   qp       y          0    24702    agentes_exposicion 
   TABLE DATA           =   COPY public.agentes_exposicion (sic, exposicion) FROM stdin;
    public       
   vespidboss    false    229   ||       o          0    24601    anos_productos 
   TABLE DATA           :   COPY public.anos_productos (codigo_prod, ano) FROM stdin;
    public       
   vespidboss    false    219   ��       r          0    24668    aportes 
   TABLE DATA           1   COPY public.aportes (fecha, aportes) FROM stdin;
    public       
   vespidboss    false    222   c�       x          0    24696    combustibles 
   TABLE DATA           T   COPY public.combustibles (fecha, solar, agua, carbon, glp, gas_natural) FROM stdin;
    public       
   vespidboss    false    228   �       m          0    24581    convocatorias 
   TABLE DATA           W   COPY public.convocatorias (codigo, agente, fecha_ofertas, fecha_audiencia) FROM stdin;
    public       
   vespidboss    false    217          q          0    24665    demanda 
   TABLE DATA           1   COPY public.demanda (fecha, demanda) FROM stdin;
    public       
   vespidboss    false    221   l�       u          0    24677 
   gene_hidro 
   TABLE DATA           7   COPY public.gene_hidro (fecha, gene_hidro) FROM stdin;
    public       
   vespidboss    false    225   ԉ       s          0    24671 	   gene_real 
   TABLE DATA           5   COPY public.gene_real (fecha, gene_real) FROM stdin;
    public       
   vespidboss    false    223   :�       t          0    24674    gene_termica 
   TABLE DATA           ;   COPY public.gene_termica (fecha, gene_termica) FROM stdin;
    public       
   vespidboss    false    224   ��       p          0    24611    ofertas_productos 
   TABLE DATA           R   COPY public.ofertas_productos (codigo_prod, agente, precio, adjudico) FROM stdin;
    public       
   vespidboss    false    220   �       w          0    24690    por_aportes 
   TABLE DATA           9   COPY public.por_aportes (fecha, por_aportes) FROM stdin;
    public       
   vespidboss    false    227   ?�       k          0    16390    precios_bolsa 
   TABLE DATA           6   COPY public.precios_bolsa (fecha, precio) FROM stdin;
    public       
   vespidboss    false    215   ��       n          0    24591 	   productos 
   TABLE DATA           c   COPY public.productos (codigo, precio_reserva, energia, convocatoria, precio_promedio) FROM stdin;
    public       
   vespidboss    false    218   ��       v          0    24680    volumen_util 
   TABLE DATA           7   COPY public.volumen_util (fecha, vol_util) FROM stdin;
    public       
   vespidboss    false    226   6�       �           2606    24706 (   agentes_exposicion agentes_exposicion_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.agentes_exposicion
    ADD CONSTRAINT agentes_exposicion_pk PRIMARY KEY (sic);
 R   ALTER TABLE ONLY public.agentes_exposicion DROP CONSTRAINT agentes_exposicion_pk;
       public         
   vespidboss    false    229            �           2606    24580    agentes agentes_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY public.agentes
    ADD CONSTRAINT agentes_pk PRIMARY KEY (sic);
 <   ALTER TABLE ONLY public.agentes DROP CONSTRAINT agentes_pk;
       public         
   vespidboss    false    216            �           2606    24659 "   anos_productos anos_productos_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.anos_productos
    ADD CONSTRAINT anos_productos_pkey PRIMARY KEY (codigo_prod, ano);
 L   ALTER TABLE ONLY public.anos_productos DROP CONSTRAINT anos_productos_pkey;
       public         
   vespidboss    false    219    219            �           2606    24700    combustibles conbustibles_pk 
   CONSTRAINT     ]   ALTER TABLE ONLY public.combustibles
    ADD CONSTRAINT conbustibles_pk PRIMARY KEY (fecha);
 F   ALTER TABLE ONLY public.combustibles DROP CONSTRAINT conbustibles_pk;
       public         
   vespidboss    false    228            �           2606    24585    convocatorias convocatorias_pk 
   CONSTRAINT     `   ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_pk PRIMARY KEY (codigo);
 H   ALTER TABLE ONLY public.convocatorias DROP CONSTRAINT convocatorias_pk;
       public         
   vespidboss    false    217            �           2606    24635 (   ofertas_productos ofertas_productos_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.ofertas_productos
    ADD CONSTRAINT ofertas_productos_pkey PRIMARY KEY (codigo_prod, agente);
 R   ALTER TABLE ONLY public.ofertas_productos DROP CONSTRAINT ofertas_productos_pkey;
       public         
   vespidboss    false    220    220            �           2606    16394    precios_bolsa precio_bolsa_pk 
   CONSTRAINT     ^   ALTER TABLE ONLY public.precios_bolsa
    ADD CONSTRAINT precio_bolsa_pk PRIMARY KEY (fecha);
 G   ALTER TABLE ONLY public.precios_bolsa DROP CONSTRAINT precio_bolsa_pk;
       public         
   vespidboss    false    215            �           2606    24642    productos productos_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pk PRIMARY KEY (codigo);
 @   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pk;
       public         
   vespidboss    false    218            �           2606    24660 *   anos_productos anos_productos_productos_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.anos_productos
    ADD CONSTRAINT anos_productos_productos_fk FOREIGN KEY (codigo_prod) REFERENCES public.productos(codigo);
 T   ALTER TABLE ONLY public.anos_productos DROP CONSTRAINT anos_productos_productos_fk;
       public       
   vespidboss    false    3278    219    218            �           2606    24586 &   convocatorias convocatorias_agentes_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_agentes_fk FOREIGN KEY (agente) REFERENCES public.agentes(sic);
 P   ALTER TABLE ONLY public.convocatorias DROP CONSTRAINT convocatorias_agentes_fk;
       public       
   vespidboss    false    217    3274    216            �           2606    24621 .   ofertas_productos ofertas_productos_agentes_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.ofertas_productos
    ADD CONSTRAINT ofertas_productos_agentes_fk FOREIGN KEY (agente) REFERENCES public.agentes(sic);
 X   ALTER TABLE ONLY public.ofertas_productos DROP CONSTRAINT ofertas_productos_agentes_fk;
       public       
   vespidboss    false    216    220    3274            �           2606    24648 0   ofertas_productos ofertas_productos_productos_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.ofertas_productos
    ADD CONSTRAINT ofertas_productos_productos_fk FOREIGN KEY (codigo_prod) REFERENCES public.productos(codigo);
 Z   ALTER TABLE ONLY public.ofertas_productos DROP CONSTRAINT ofertas_productos_productos_fk;
       public       
   vespidboss    false    218    3278    220            �           2606    24653 $   productos productos_convocatorias_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_convocatorias_fk FOREIGN KEY (convocatoria) REFERENCES public.convocatorias(codigo);
 N   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_convocatorias_fk;
       public       
   vespidboss    false    217    3276    218            l   �  x��[�����O��eWy'8�@�a8 ����\�6pr�:�9w���+g�:�b���(JE@v0,I#4��u7�y-7�wdHF�Ux/����ҽT+�Z�R��D�������`ŋ|��Ud5y=R�'"w{��/��X��
�~��l!!�E��HL�>�F��SXא��vU���"���Z� I6za��n�2m���4Wd���؉&5L�
��u�$U!��imX��T��HL0�mȗr)����Q'��m4�ŁX'�4;�����؛��f)�r�)Y*�ۋx�6�/7��M�%6+*tFm�)��N��BS�S)�WH�t�-�?��kO�T�;#��v�6OS��R��6��i�OZif���ԋ���Q�b~j�'�^���k�0u��-�T���x�Ǿ�ҰF��L �)������=�U�H�׶���K�`��0f����m㎥��>I{���:�h������^��j斠v�{=9F'${J�|Z).���&jXh���,,|�uSKrF�"�w¤�RH=G9������im���|V
K���vamKЁ�vEF]+sׯI�z�'�\�r�T�I�U�Qa^��R<��.Bk��߲Q}wQ4,\ÑJ}�#P���vvD`v�ZFK1*�s�`(Y.a͓x/���C�,p��M��;�2�!Bդ�b��[�N%��Jnt��pO�T�I�H����ڙ������?������C�`NG�u��{G�)���d��>"���x����'�o]-�	�L����=ԝ^�y�Ԟ���ѕ�8@l�,ݢ�[��%�z$�a�}�u~ߩG��{��Q|"�Rc��:�CNq�Aόg��?���,�����˨[��y�>��POYG����g1�x�X���M���6C�53�>���K�_-+���!�
�8#՝
��=�~8|>�����k�ԗ�R��8�p���C�r|'��r��3D7�Cg@���~�/T��h�M�l���)�5�jU�]�6�����"b�c�T.'��9޲W�A'�.�b����M��x:A8ާ����OQ�bk�A�������?����?�}W q�u�x��歽z�P���5�-+�(�m{�.Y�{*߽�+�����f�3�a��p��r%m���:/iۛg�*Ҩv��g�� ΦV�������J������*>=}\L�U��W��e|Xف\IZ�F�p�����b����u�@�£d��'/�꭭-�큡MK���Vɇ�V[���8|"p�(�����x�~�B��0Y���R`bn`O�����T�4�S��<ɉ�H�E�+����G@��2��)��
}�-7
A q�b��*	{w�ո& O=��� ����B�I�n���N]<�t��T3b�Z��ɹ%�rF��Cǭ)n͂��o��P68���G��#|\Q_��P�vd�7�؞�Ѫ%�c�i�?��s,�Q�'1NTo��n8 Q��ߞ2�ty��5�&������8#g�6t��{.�λ�G&���Jq����.�2�+<��ϖ�X�����1�V��-�����)һ.���g�����g2�;i���<X V XHU�/ckO�0׳�5���ٛ!�i�Q�EA<q�{�0K!�<}e��ݟ�K$�\�2sqw�U�g�\:��!�������v�}V�ȩ3}x)�	�u��I�� ��ҙƛkԊ�� ��޲j��
>V��{|�	QpK�w�sl��o�I��n�zr��;��tYD#e�E�uY��W�B���J�E椖�LW˻L7vܹ�x�k2���:���0���`y��8����E7�3;9]ڹ�i���P��_2���7r�7�5�o�[�&Pg<8��Cv$�oal���,ff������7�,��]+J2KÝw<�.ё���t�d���{jL��6�ǰ�9��%�*��Ԫ������/�eaސ��PV*Z�4�x.��l읉(�3$�L�9Pe��dK�g~cl���f���"2d���s�%Ԭ-:9�G�ՀA��<�Do3�J�xNz9�~=r�$������|I�n�d�����5��$�3�ڲ�C��`j��쑌q_��Z1�ṑ�Ur�ZnU����� j�3X�8��'e����l�"w�0=7��r��FD��/ǮG,�����jh�ͮ��x��Ay�w%�rH:��c�V�ǀ�B�pI�\�=�]O�$:�ۼ��uJ3��ܽ-��ި_id��n�:\E�,�`������ÿ�����(�s;hV����M>ýC�,4�kT�x�y/+۶$v$Q9���Z	j�AH9tAO���8�|���Pn���j00
��;Ig]������ۚez�2�x0ķ+�|����:v��2����4��#��Ϫ�z��U��� ���-��G����h��]�q5�}q�\�Ź&e�YӦ�*�󂲇����|1��v)�n����-)�W$�^�~�C�%ۘt�
8㈀�z�ͪ0����U]��pVrjD=�zNs���H�ak��rn��c8�u,ӽ��kQ �:2�Q��؋?��l�e��@[�+�J�}�p���<���\���8��2��f�р�����J�Չ�k"Ƹ�/�'̑��>�p��4=٦��[`��s���Q���]@��XC(uj�#K�6�/�T�%����T.u��So��U �V�\�ǘ9��� %�M|��'F�۽�xڞ���o�ڞ�Y��ys�x������r6�y���Ls���z?���HZV'����s0/;6Dٯ.��^�ǁ''ϼ��\m�L�#�:��/gy`��R�N������[0*jW}Ѷ��*:��d!�üq��9�ɧ���ہ���5�t��hgI E;�ǷQ��2��-�Z^�# ����啼ue�uOV�D�9pe��-˒n�c�dE���t�|�I���	��ŕ�s�Ri/��B-�|�m��K�����f�
�Lϝ���C�m�jK��vZ֊,��}7xp�����d�5�R��K��m<|���I�$K=�2��PN��r2��;�N�k����Ç��i�      y     x�E��n#9�ϫwC��x��'@��;�d��}�W؏��;&�آ�bUQ����׏x�&R5F��,�p<G��������V[8���_�Ps����b������۲�l��ƞ,[�?�N���J�t�n�|���ؔk,�%��
�������\s��KXN��E���c/��^�r���"���3?ђ���?�z�B��ZJjE+���bU�մUӘ<4 h�+7�Ukl9��u�d9w��k�FyJ�sԛLb�Z�6M���J�P��D���DsX�ב*��"hJ�\�����A�Q����jo�Le�m��]�,���hM8���T-����w�_��l���j����ʷm{�^Hئ�I8�?��ޭF�ג�C���z�ؗ��I�z��]��j�Nf��<��4�w����<>w&Y��T5%�B�ר�:��2��0�ub+��[���{�)Ƒ�������˪�]��A����d2@�\�Ԗ��|��dN�R+��|��0�?�f���o�p1��Pȃ���Y������#�	
X3����e�Qp��d��4�_Q+aQFg�w^2j*��
\3h��Γ�	$K�4�聋��i�A�4
�"���eY�9kI��Yr�����a�����:�1ˬ߼|����f�֝��3c�Ւ���1yh�WzB�)R	S��}H$e͒:z������\���Bu-�����%���A�<4P��,rB��'x�z�'7�
$� Դ�O� ��r���� ���kl�5`�ط��Gn�����B?�Z~n�b�g1�33����P�>(&�����F�M�ɀC~Hd
擤v��M����X������)=\���G6J�H�G$���˺L��U�d�@�������S�D�66�9�88ݹ�m����qF�\�|�9���jK�Z�ܿ�aGIM�93k�p�|\H>e������� "&8�\V|��m��0�:t�ϻ`^��$A6	���w�}=��JbH%�
�e�5)�D�[����@,�S
����l�TI�& �%����gh�;`mN7\�����2�=v떽[L<�u��UJ����>v���9���N%$��4�}�A"-�֏�$��zV�x���>+.�S�>@Dt��}��V��.!�r`��FɌm�r_�4��2�Q����(�;���ЦP�O>�P���Y�=mct�S� s����Y�ܢV�G����mV�B������$S�X,�iL?��[��?�o�?v�I�xl��~����p|;e2���fچ�0�
���~�g@���4���ٖ�lX,��eװ�'U�^�q7xp���&�H��u|�>|y��{�C�9����Pܾ8�t��Kq�\��@ڗۈ����6V�$��!0|�T؉<*����lÊ��ė��ϑ��>ݮ�<&��C�c���?����	��W��u��6?�#?|d��N�Ţ������m<�����6��aU7������zjb>�o�'����F}_Nϒ�?pJ5�����!��/˕F�      o   �   x���;�0��%��@��H)L���A�R��Y��^���8�a�s���Ak;��u�fG�*Ifɂl�,���F��|"s�����%m��gA�,h�-�d�dG��՜���"�d���k9�|ˉ8�H]�8gA�,h����Z��T�=�o��X�	�n`�&��M��&R)�{0o7<�J��_�      r   �   x�M��m@1C��.��C �����ϡ"�ll�)����k��fҽ���3������J��H�8�48���L�V�ęT+̮�5ݣ/X8����T���O7�@}5Hė�Xb���;T�����-��P5Xײ�c;S�{F�T\�5~9���GNJ      x   �  x�M�[��0C��^��0�����:� �8?�iz"$AMl��M^�[y*��n�Ų/�1I�m7�����o���I�{#�� ��-���z QN�,�����<�L���&s�W(�a��f�/�`1X.�҃Չ�A3�*����D�$�mkf@jCjMt�([�,�y���|N�A��1�84�:x��qf�ϴ	!(�%�(�[��ܐX�xdm�q��&v�M����4��-~�&�ԃ�y*r�,lT��b_����Y^��G6��[�Y�a���L��%�ZJV���,=��u���ߎ�@�t��:Yo�g��c():
Lc��-s~�	�:Z(m��H{��@��n�Q�ppk=����(E5�<��v(��6ª�č�z�z!�i;�?���Ꮸ�      m   �   x�m��
� ���{��$:Zv"�0����ϱ���v��/�3�OҒ#@N�	E@�]��i5�[�'�_u��Sh�H�2�^~��Fg���^��d�Br
[��6�� ���s�ev
��@�~�\�}[���A`����a�)X`�@������7T      q   X  x�U�I�#1D��]�B�ƻ���ѐؕxgg �'T�u������:�ҷ~�PdR�T�6믻"���/��Ρb�X����֋�銵]-WF�f#��p^S�����+�$�Q���������`E��iW�x�z�/@��b3_rwFe�^*^�ɏ������\����jRAY���G_m���h���%E�P:��T�J��`T�(�s?�
����INg�Ts��*팮��i�b9�&��z��3,6�G/~"���{�@��<7�O�l�t���d�gaT=�b3k*���6�?�t��U�a�zQ.���l��������"T*+6�jVl&b�k!V��vqsp�����A���e'#n�d��i�*��m����2������ym������+v�W��m����B�nQ,!$`���O�h�ft1�rjC�6��aMJ��+i��+��C�`�c���2S��P�a�A���nI��\�~�Q� |33A͔Oi�;ʩ\ċE��;����S͜G9����S�s�c��ܲ�$����/+�����\}P1P�˩�&/��{X֜���uPNm��r�T�sqj0���$�K/�)`��E?�/���|W?��N9�+C)l8�����p��	V��i>&��F�!ߒ�P��H��-����W���|������9��X�����z�pd�K~�I����W�&*|[>�Q�������� 6�p�	��$?*���[g�w�xE%��5�|7<?�~!),�-�w>-�&ߍ]���)� � ���9�Y����4�-��'��A�ƈ��Me!�^N��(��l�Sbe�~������ڐ f      u   V  x�U�[�C!C�o�2y��^f����5#����׆������K��>$u�1I�Qu�E�05��d����%6�gJ(�%�;H�Q+�"	h��m6������%�cI\�׳�����)�;\��>{��(� ZbFbM��x�hAs�֜!vy'���^���\S<�DG����8�"����Ƴ �tJr�|�f��<3�6 $ȀK/'A����ٵɐ��S���P��H��Lt� C����^�o
��d^R�<��H�7'ڱ<X�y�s:��m9.�{�dw犕]�|����5q S�̾�o#�����$�g�� AN�����������������Ｙ�      s   Z  x�e�I�!E�]wi���k�ʯ����<����;�/��3����te��P���V�w��C
��\���b��u+FP�+6�b�[�TlA9?Lwh�s���V]�!��Kd{�*h�P�
�3�
-(ZV
ey�;6zU��(^��X-��3�>Ϻ��"�J]�ί���N��=��s��Y�)���Ȑ*gm~N��i�<g�a�GΫ�̔u�0�.�a�JQ:k�A6������O�)�k�N�]�3�x�e��!%��y����8�)���4��&Z�~/K7ˠx����G��$���7�I�
ވ��w�I��g<�y��Τb�CP,cRN*��R���fJP�r4��C���zP��sԢb�g�rK0� �|�-c����\��UIQ`CJR��xf$HJ�d@'�J�����xz��D�5�.ŀ_0����L
�s��`�[���[���RV*��X��bEK�Ǩ" ����Qz0�GZ�\)/qq{*'��$! �0�j%9�*����]��c4���M�52?V���|���rp��A��3��E�a�r�B�`�p-C/��X���3�e�_�I�Y�\k�'<'+w0��gF�Jl��Hm��ނB�F��{\P3�9vv;s�W�lj\��^"�^*}�r��ӂ�w�PbY6/����dP,��n)\˘�.�g�%�

h['%�+�������h;4����ܬ�G7dHI����ܤ��'���3T��QEb`xTk��~S4���G����"98_V;�H�礲���ћ�\�����4(�n���A�jo(�
��P��P͌��D53�����+g���x�^9� �      t   N  x�U�K�� еs����]����Q�h)�<5��:���HP
o{��RY'`�N6�^b
HJg�tP.�JcG�jg��3����E��F�^U4y��.���Bw��R��o��:y] ����zZ�GK�cA��{��H*$NNL�9��E9x^kz���<��"�$9�m�Ƣ_R�����28�G4!qV�Ϫh����d��/2�`�9� �,x�5.n< ��z��/`�3NQ��^5.���ٚK�,r� E��m�+46�ְ�ĵG�N���Y)h�N����W3{P*t�=�辠�/���uO����Kz��5՛��^���y� �۳�      p   -  x���Mr�0���]�!	P$��M:�8n�v��'�����v��d�� �OZ���x���Zz8��>Z7��o��.Ow���yY&
�$���?�(��	C緗��2U�#���Y"��i��T���b�!Īɛ�;K�L�n�I,��L��D�u���0};=5(���U����*X��M�j*��KM�l(`�i�y`)~FSMΚ �E�T��4��B�����T�4 ��T�i�P���1q���W�����!��fƏ�45$�\�DsD<p�m��˪7̰�)�߷���ń8��#�u�s21 5s����7k��4���wPTG9�Qy&u��|�3���a��j�'f��U�l�4p�?�+�&A3����M@�n�/-���j_\��T|����¼���dĪ�-$fc�2,&Z�̈́�þ�L�I���X�a�W��������A�,�#���� &�/2&Z^fh�jC{B��M�L����D��v^�	�V���}5����w�,�]��0�DLslV|���*���ob�P��t7+�d��~����OꞸ�XY���&��|�-3�$�nMD��P��`�|1#o��.$izg���H2)�~��,���[�c��o�`B���EvOx="g�R��I�C�ނD�F���0����z�����_Bۖ��b@HP�R?���/_+�#_�������㷠&�B�<�~=����bMOD�,��ڀ�j,&�E�Y7�Z\e�EWиt<�Nڣ����t���/�[G���Q�\�P!ԮI�"�h�f�������+      w   o  x�]�I��0D��]�g@�]���h���e=|I�K���/����G�uk%-�������u}g��[w�ۭ�B������C6oG�~��zz�\Z.�Î�]�G������S�x1N/�>΀�iڄ�i2��n>͠t��S����\���woڇ��^�b1�ՠ�OFq�F���S�΋�u,��ݑ���/�C����Q���،V���m_������/ߒc1h�S��Z�ݭM��Zq,��G�������+�?�N�cZp����3��g���tB�?����C�?�	�F�n��N���$\�܉q� ]���K�����A��}�[{��/��Ry��4mK�\^��%�B���>`V���L*��,+�mw,+�K:���&t?�cs,҃%�W��(I悤a=V$+��}�:v�I��V�{)lV�ڍ>�V��9M�tp���~�Eɝ_gMΝ�'�֚�)���wM�^�3>�9��Y�s��~��=�N�蟠a?I���uA�DM�ڡ���B�>Y��I���I�g!X�_�o�<o0�wZ�$�J��'I��"�֭]�Ѕ�'M��.�<��䭥�s������q=����@yh�O�$����4)���������p      k   �  x�U�˱X)D׼\L�/����[ؾ��v�h�#�.�_+~�w���_��0�y�����*�k�rf�6ϥbC}�H*>�ʼA%��5���a�s5e�O̫TΰЙ��Ed��{�%HB�S����~i!	�=���:ͨ �S�2WPA"3[�l�v�z������^9�M�O��
�tބȫ�*��*_�.�,��Y�:�튡�Nk�7�3�.x�vP�9��%(��Y������{`�as�p����(u`�s��7�hkPf<-��Bx����*[a��:[���	�N���e2�I(���PJ�U�s(ŸPۗ##�i�i6Ũ�qai�8w\��M`��!u^l�#��]�l�4�Aѱ�N�m�?��%�!k��Y��LJ���ĺ�z1��& ���Dr�yh	�G�b�j[�@D.v�ހ����v�1[`X3ڔr�<\ߓx�O�^|
��.+�ϯV8�FD4�m>�V4Һm���v�����/%gV8Z�8��u�q��aC�s��a�"ڵ[�����h;����ܑx&i$^����zS��#,38��=	p��H���.���p58Ӭ@8��M����H�YC$��3
&���$fч�,y�]����L���5%�8�V}�$�>V�p�j���8�XA�6/V�FxT��m��cd|CD+h������DO�V�9���2�iJ�
}���l@�x4�Q`%����7c�O���*�g�*q�;֢��u���� N�:5U��ߚj��@`P?.ꇤt#��~_g�{1RءRT�~�����"o~h\�7?�~� w
��\2]R$&w�m@�ԫ���2IS��(���b6��i�x���y���m��el���J
�X�2�� �0r���X��[�;wS��΂��7T���[T�%x�cp�x�H�?�͟���E��      n   �  x���M��0���]"H���,� �(Ҵ鲛��%�x0	i +"?P��Y��t>_W�ȧZ�t���{m�X��U���,kF Ь0@�� ��:@5Bm��.��@��Ǐo~Fvƻ�
,�Ru�N��~F;A�
h��ұ[)��R&�z���SގEm�f�3E�SfD�2LÈ7�RN	��2;����Ro/b��S>DKW <�u�ޢ�B�6�^�!3�����HQ�9E;E�&��Ԗ�� �G�֜�!(��Y8�7\/�\�vy�����z@��"yq�6�۷3�$=v�P�7�k@嫧��)����+d�;D~�	�����T�;����i hhx�Z�Ė�H��\�IB̸',�A�@�z�ss�i�c ��N�n�s�>�T�[��-~����[�e�X^      v   �  x�]��m1�s������K��#�l�(�a�В��>������|�Z�mM�m��߇-d%�vO��Hw� Or䝯�C�|����T_��4��AY��<ji'��y�#_�ёn��7�J6r�[�N����U(Oe��J��J�앣2R�k�-J������BV����Ƀ<��V�iL�N�I���N�G��A��U�����Nj��N��y◔���m��MYq��7`�7��0^4��&�
O�+��B.é4�z�s�;y�r��$z�2��$��r��$XɆ�No��2z�O�B�3���-�l����ld'�n�A����u�|yY�ot�ki#G�d��t�]�����]���O��uV|��.d��cT2�������������r��+m���t'����WuT���z^Ũ�<md'G>Kr��t��ш2э�ZZɑ/�q���F��_/�D� ���������O     