PGDMP         6        	        y            financas    13.3    13.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24599    financas    DATABASE     h   CREATE DATABASE financas WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE financas;
                postgres    false            �            1259    24740    funcionarios    TABLE     s   CREATE TABLE public.funcionarios (
    id integer NOT NULL,
    nome character varying(50),
    gerente integer
);
     DROP TABLE public.funcionarios;
       public         heap    postgres    false            �            1259    24738    funcionarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.funcionarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.funcionarios_id_seq;
       public          postgres    false    216            �           0    0    funcionarios_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.funcionarios_id_seq OWNED BY public.funcionarios.id;
          public          postgres    false    215            J           2604    24743    funcionarios id    DEFAULT     r   ALTER TABLE ONLY public.funcionarios ALTER COLUMN id SET DEFAULT nextval('public.funcionarios_id_seq'::regclass);
 >   ALTER TABLE public.funcionarios ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            �          0    24740    funcionarios 
   TABLE DATA           9   COPY public.funcionarios (id, nome, gerente) FROM stdin;
    public          postgres    false    216   S       �           0    0    funcionarios_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.funcionarios_id_seq', 5, true);
          public          postgres    false    215            L           2606    24745    funcionarios funcionarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_pkey;
       public            postgres    false    216            M           2606    24746 &   funcionarios funcionarios_gerente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_gerente_fkey FOREIGN KEY (gerente) REFERENCES public.funcionarios(id);
 P   ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_gerente_fkey;
       public          postgres    false    216    216    2892            �   K   x�3�t�/�/K�I����2�t�K)J-.N�4�2�tK-����II�4�2�t�r�3�S��ԢL�6c�=... 9��     