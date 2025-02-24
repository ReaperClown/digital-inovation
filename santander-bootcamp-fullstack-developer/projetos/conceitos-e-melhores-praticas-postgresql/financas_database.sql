PGDMP     0    7        	        y            financas    13.3    13.3 3               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    24599    financas    DATABASE     h   CREATE DATABASE financas WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE financas;
                postgres    false            �            1259    24607    agencia    TABLE       CREATE TABLE public.agencia (
    banco_numero integer NOT NULL,
    numero integer NOT NULL,
    nome character varying(80) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.agencia;
       public         heap    postgres    false            �            1259    24600    banco    TABLE     �   CREATE TABLE public.banco (
    numero integer NOT NULL,
    nome character varying(50) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.banco;
       public         heap    postgres    false            �            1259    24621    cliente    TABLE       CREATE TABLE public.cliente (
    numero bigint NOT NULL,
    nome character varying(120) NOT NULL,
    email character varying(250) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            �            1259    24619    cliente_numero_seq    SEQUENCE     {   CREATE SEQUENCE public.cliente_numero_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cliente_numero_seq;
       public          postgres    false    205                       0    0    cliente_numero_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.cliente_numero_seq OWNED BY public.cliente.numero;
          public          postgres    false    204            �            1259    24658    cliente_transacoes    TABLE     �  CREATE TABLE public.cliente_transacoes (
    id bigint NOT NULL,
    banco_numero integer NOT NULL,
    agencia_numero integer NOT NULL,
    conta_corrente_numero bigint NOT NULL,
    conta_corrente_digito smallint NOT NULL,
    cliente_numero bigint NOT NULL,
    tipo_transacao_id smallint NOT NULL,
    valor numeric(15,2) NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 &   DROP TABLE public.cliente_transacoes;
       public         heap    postgres    false            �            1259    24656    cliente_transacoes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cliente_transacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.cliente_transacoes_id_seq;
       public          postgres    false    210                       0    0    cliente_transacoes_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.cliente_transacoes_id_seq OWNED BY public.cliente_transacoes.id;
          public          postgres    false    209            �            1259    24629    conta_corrente    TABLE     G  CREATE TABLE public.conta_corrente (
    banco_numero integer NOT NULL,
    agencia_numero integer NOT NULL,
    numero bigint NOT NULL,
    digito smallint NOT NULL,
    cliente_numero bigint NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 "   DROP TABLE public.conta_corrente;
       public         heap    postgres    false            �            1259    24740    funcionarios    TABLE     s   CREATE TABLE public.funcionarios (
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
       public          postgres    false    216                       0    0    funcionarios_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.funcionarios_id_seq OWNED BY public.funcionarios.id;
          public          postgres    false    215            �            1259    24648    tipo_transacao    TABLE     �   CREATE TABLE public.tipo_transacao (
    id smallint NOT NULL,
    nome character varying(50) NOT NULL,
    ativo boolean DEFAULT true NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 "   DROP TABLE public.tipo_transacao;
       public         heap    postgres    false            �            1259    24646    tipo_transacao_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tipo_transacao_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.tipo_transacao_id_seq;
       public          postgres    false    208                       0    0    tipo_transacao_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.tipo_transacao_id_seq OWNED BY public.tipo_transacao.id;
          public          postgres    false    207            �            1259    24703 	   vw_bancos    VIEW     l   CREATE VIEW public.vw_bancos AS
 SELECT banco.numero,
    banco.nome,
    banco.ativo
   FROM public.banco;
    DROP VIEW public.vw_bancos;
       public          postgres    false    202    202    202            �            1259    24707    vw_bancos_2    VIEW     �   CREATE VIEW public.vw_bancos_2 AS
 SELECT banco.numero AS banco_numero,
    banco.nome AS banco_nome,
    banco.ativo AS banco_ativo
   FROM public.banco;
    DROP VIEW public.vw_bancos_2;
       public          postgres    false    202    202    202            �            1259    24717    vw_bancos_ativos    VIEW     �   CREATE VIEW public.vw_bancos_ativos AS
 SELECT banco.numero,
    banco.nome,
    banco.ativo
   FROM public.banco
  WHERE (banco.ativo IS TRUE);
 #   DROP VIEW public.vw_bancos_ativos;
       public          postgres    false    202    202    202            �            1259    24721    vw_bancos_com_a    VIEW     �   CREATE VIEW public.vw_bancos_com_a AS
 SELECT vw_bancos_ativos.numero,
    vw_bancos_ativos.nome,
    vw_bancos_ativos.ativo
   FROM public.vw_bancos_ativos
  WHERE ((vw_bancos_ativos.nome)::text ~~* 'a%'::text)
  WITH CASCADED CHECK OPTION;
 "   DROP VIEW public.vw_bancos_com_a;
       public          postgres    false    213    213    213            �            1259    24751    vw_func    VIEW     M  CREATE VIEW public.vw_func AS
 WITH RECURSIVE vw_func(id, gerente, funcionario) AS (
         SELECT funcionarios.id,
            funcionarios.gerente,
            funcionarios.nome
           FROM public.funcionarios
          WHERE (funcionarios.gerente IS NULL)
        UNION ALL
         SELECT funcionarios.id,
            funcionarios.gerente,
            funcionarios.nome
           FROM (public.funcionarios
             JOIN vw_func vw_func_1 ON ((vw_func_1.id = funcionarios.gerente)))
        )
 SELECT vw_func.id,
    vw_func.gerente,
    vw_func.funcionario
   FROM vw_func;
    DROP VIEW public.vw_func;
       public          postgres    false    216    216    216            Z           2604    24624    cliente numero    DEFAULT     p   ALTER TABLE ONLY public.cliente ALTER COLUMN numero SET DEFAULT nextval('public.cliente_numero_seq'::regclass);
 =   ALTER TABLE public.cliente ALTER COLUMN numero DROP DEFAULT;
       public          postgres    false    205    204    205            b           2604    24661    cliente_transacoes id    DEFAULT     ~   ALTER TABLE ONLY public.cliente_transacoes ALTER COLUMN id SET DEFAULT nextval('public.cliente_transacoes_id_seq'::regclass);
 D   ALTER TABLE public.cliente_transacoes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    210    210            d           2604    24743    funcionarios id    DEFAULT     r   ALTER TABLE ONLY public.funcionarios ALTER COLUMN id SET DEFAULT nextval('public.funcionarios_id_seq'::regclass);
 >   ALTER TABLE public.funcionarios ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            _           2604    24651    tipo_transacao id    DEFAULT     v   ALTER TABLE ONLY public.tipo_transacao ALTER COLUMN id SET DEFAULT nextval('public.tipo_transacao_id_seq'::regclass);
 @   ALTER TABLE public.tipo_transacao ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    208    208                       0    24607    agencia 
   TABLE DATA           R   COPY public.agencia (banco_numero, numero, nome, ativo, data_criacao) FROM stdin;
    public          postgres    false    203   �B       �          0    24600    banco 
   TABLE DATA           B   COPY public.banco (numero, nome, ativo, data_criacao) FROM stdin;
    public          postgres    false    202   mI                 0    24621    cliente 
   TABLE DATA           K   COPY public.cliente (numero, nome, email, ativo, data_criacao) FROM stdin;
    public          postgres    false    205   OQ                 0    24658    cliente_transacoes 
   TABLE DATA           �   COPY public.cliente_transacoes (id, banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero, tipo_transacao_id, valor, data_criacao) FROM stdin;
    public          postgres    false    210   �x                 0    24629    conta_corrente 
   TABLE DATA           {   COPY public.conta_corrente (banco_numero, agencia_numero, numero, digito, cliente_numero, ativo, data_criacao) FROM stdin;
    public          postgres    false    206   _�       	          0    24740    funcionarios 
   TABLE DATA           9   COPY public.funcionarios (id, nome, gerente) FROM stdin;
    public          postgres    false    216   �                 0    24648    tipo_transacao 
   TABLE DATA           G   COPY public.tipo_transacao (id, nome, ativo, data_criacao) FROM stdin;
    public          postgres    false    208   p�                  0    0    cliente_numero_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.cliente_numero_seq', 500, true);
          public          postgres    false    204                       0    0    cliente_transacoes_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.cliente_transacoes_id_seq', 2018, true);
          public          postgres    false    209                       0    0    funcionarios_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.funcionarios_id_seq', 5, true);
          public          postgres    false    215                       0    0    tipo_transacao_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.tipo_transacao_id_seq', 4, true);
          public          postgres    false    207            h           2606    24613    agencia agencia_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.agencia
    ADD CONSTRAINT agencia_pkey PRIMARY KEY (banco_numero, numero);
 >   ALTER TABLE ONLY public.agencia DROP CONSTRAINT agencia_pkey;
       public            postgres    false    203    203            f           2606    24606    banco banco_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.banco
    ADD CONSTRAINT banco_pkey PRIMARY KEY (numero);
 :   ALTER TABLE ONLY public.banco DROP CONSTRAINT banco_pkey;
       public            postgres    false    202            j           2606    24628    cliente cliente_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (numero);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    205            p           2606    24664 *   cliente_transacoes cliente_transacoes_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.cliente_transacoes
    ADD CONSTRAINT cliente_transacoes_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.cliente_transacoes DROP CONSTRAINT cliente_transacoes_pkey;
       public            postgres    false    210            l           2606    24635 "   conta_corrente conta_corrente_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.conta_corrente
    ADD CONSTRAINT conta_corrente_pkey PRIMARY KEY (banco_numero, agencia_numero, numero, digito, cliente_numero);
 L   ALTER TABLE ONLY public.conta_corrente DROP CONSTRAINT conta_corrente_pkey;
       public            postgres    false    206    206    206    206    206            r           2606    24745    funcionarios funcionarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_pkey;
       public            postgres    false    216            n           2606    24655 "   tipo_transacao tipo_transacao_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tipo_transacao
    ADD CONSTRAINT tipo_transacao_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.tipo_transacao DROP CONSTRAINT tipo_transacao_pkey;
       public            postgres    false    208            s           2606    24614 !   agencia agencia_banco_numero_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.agencia
    ADD CONSTRAINT agencia_banco_numero_fkey FOREIGN KEY (banco_numero) REFERENCES public.banco(numero);
 K   ALTER TABLE ONLY public.agencia DROP CONSTRAINT agencia_banco_numero_fkey;
       public          postgres    false    2918    203    202            v           2606    24665 R   cliente_transacoes cliente_transacoes_banco_numero_agencia_numero_conta_corre_fkey    FK CONSTRAINT     G  ALTER TABLE ONLY public.cliente_transacoes
    ADD CONSTRAINT cliente_transacoes_banco_numero_agencia_numero_conta_corre_fkey FOREIGN KEY (banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero) REFERENCES public.conta_corrente(banco_numero, agencia_numero, numero, digito, cliente_numero);
 |   ALTER TABLE ONLY public.cliente_transacoes DROP CONSTRAINT cliente_transacoes_banco_numero_agencia_numero_conta_corre_fkey;
       public          postgres    false    210    210    210    210    210    206    206    2924    206    206    206            t           2606    24636 >   conta_corrente conta_corrente_banco_numero_agencia_numero_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.conta_corrente
    ADD CONSTRAINT conta_corrente_banco_numero_agencia_numero_fkey FOREIGN KEY (banco_numero, agencia_numero) REFERENCES public.agencia(banco_numero, numero);
 h   ALTER TABLE ONLY public.conta_corrente DROP CONSTRAINT conta_corrente_banco_numero_agencia_numero_fkey;
       public          postgres    false    206    203    203    206    2920            u           2606    24641 1   conta_corrente conta_corrente_cliente_numero_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.conta_corrente
    ADD CONSTRAINT conta_corrente_cliente_numero_fkey FOREIGN KEY (cliente_numero) REFERENCES public.cliente(numero);
 [   ALTER TABLE ONLY public.conta_corrente DROP CONSTRAINT conta_corrente_cliente_numero_fkey;
       public          postgres    false    205    206    2922            w           2606    24746 &   funcionarios funcionarios_gerente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_gerente_fkey FOREIGN KEY (gerente) REFERENCES public.funcionarios(id);
 P   ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_gerente_fkey;
       public          postgres    false    216    216    2930                �  x����nWFk�)X&�ޟݻ��l$E� R�YKB@D"�E�)u*�z�PI� ������1l8u���;J���o��w�f�����rؤ��a�e��67��y�����u�����x}q��ۜ���j;mR�PʇR��VKM��"��F,�Ģ�9�j��8h��8j�vNlq:'Nq>'�1m���Vd"mDo'��$�N�I@�$ړ�>I�'��hP
%ѡ$J�E	h�D�2�(�e�QV����Qeѣ<ʢGx�E�2�(�e�Q=���,z��GY�� ���Qѣ<*jɡ�=*��"zT�GE�� ���Qѣ<*�GxTD�*�U�Q=���*zT�GU�L�>�U�Q=���*zT�GU�����QUѣx4H�ӗ��+|\�^I3U�𘙂��L<<f���1���%xx�$��c�7Ep���HM\Dj~�"R��������E��."55p����g651p�y��HM\DjV�"R�����Ԕ�E�f."5!p����K�逋H�\Dj2�"Rs��
���L�&��O�������d�ɔ��Ĳ����$��T�Ʉ�ɴ���J�JE�Ju�J��JմJ�J5�Je�J���'=�^(��^(��^(U�^(�^(��^(��^(U�^(�^(���С��=U-�xw����_6��;b��c3���f�����_/���^6Ӄ�l&{�L!���T�es��M�ⱛNUd7���n:Օ�t*0��Tivө��S��M�"������n:���t�O��T�vөb��S��M���N�l7���n:��]���F��.�?�ͧ�����������x:cy���A��]��~�z��s�#���������箇g?w=:��Vp
d#6��وL�l�@6�R a)����FP
d#&��#$���H�lģ@6�Q �(��`�F,
d#��Bo�P�l�E�Ɲ�l�M���l�U���@6v��� ���᳉�� ���ll:dc�A [��}���@6� ��!����s��!���C��ppqp !��!f�F1!��!��88�88 �����C��c��#ppqp�!���1��88��C�@4��88�88�G���`�p��8؀�-��l!6�`q�[��8�b�J��!6�`q�[��pp
qpN!N��)��	88�88�'�����B���S̳A�p0��	88�88�g�����C���s��3ppqp�!���9��88�88�'��}�3z��>�)�=���<�ߢ�[��r�R�����������o�����.����t���t��Y��v��m��c�/���~(���AaǬ�
;f��P�1������d�2�;ȸtw�q)� �JR�A�����Kq���2�3�d�n�{G5.;�d�}�;ȸ
rИ�ź���r��SK�u�w,�Sׁe��:��&]�Y��b��z�~>/���{&���2/�ʼXn(�R��̢��l8���Y�A�vw�}y�Y�#3�|0cg�3|0c;�3V|0c�3�|0c��3��8k����
�8k����V�8k_����x�/ח���"      �   �  x��ZMs�8=3���ݪ�J�I�&ʲbO$�$;{�L�2��IW���Ô9��%W��i��1�esvI����~��i�Y�bAF��ޒe�d����r��}���!��s�=w�� �\���x��EcI��hT�@�}�6�g!i�9��A�# �P��Z���Dt�����L������8�/9��@��b����5�L���t�X?ԯ�~�$	#+&�y�������J�����߂02.��%����N�S̱�^?_�������3�	��󂒫�`�i�SVp�L��dy�<��|�	p�8f�'�����u(\a��N�c*��?x��w�K��?p�aY!0678�� 9�c���j��v
�%��g��y����3�1�:���`��_(�B������[^���7��)x��c^@:eO�D�t3N��<�f��Jl���J�-�?��g���/�*�4�1�|cQlU"�gqB������&jsD����%K0E%0�[:��q������qA�%�>e����&V%�sF��X�+�Cc��ʸ�]�*Q7�͋UoI�b�N$��Z��q,t��G 1��S~/�K,�Q���u���H��Bd J�ذ}K�G��\Ѯ�9*Y�;��mf�#3K�-�S*�Fr8�$�X��庤/mi�7�`2���r��MV]L������E��x���<����C���q. ]2���{wx^�M@"$b�w�|�*�����*�+����洬��Om��=#K.�T�n�NWooh.$��uS�F�\�B�t��^�z�7�8G5����5p�Ѡ�'�Ĝ��iI3zOq7�ǻڵ3��qV}O�ME���,-.U���j����vP�1r�=4�#P����<�[̫�C��Z�Ai�=N�U��]�$J�ء�rA�� �1R�۟V����j���=�葙�k�>�=nEP��ؚ���cF.��3G��"B�%�ˏ��Sp���~*s��E�n:g@G��C�`3�PȻ�R`'3� i&4�����DFA�����@��z��7��L�p��
Y�/0[���jT�$>��:۶�iݶc@f7W�q�q�9T���o�Q���� ���ٺD�n��(X�%bM (�-j������	kn͠'l���А����p�k�!o�@��.qIUK��\���B2V�ɲT]����U����@�~���+�*��d��n��u?Rh�P~4[����Ҝ��m��K�[��WoE�F��[V��+;�����+��Qr�E�	�������΄U��� �F�w�`���݊m������[ɫ��u��F�z��Ļ�}a��:�>/Q��^�wp�nb@QF���v�:�G}�$�V�$/��h��A�m�?�hʬn�}Yf���*�ԩ��D�5eOi	��s�^�ک�GeP��O��Aǐ9�zXQDt�ؖ)$j'U||4�;Ɵ�6�,j���b�M�	@�,#�덕��[�+��Z�-��nLJƲzK L�F��(�۾�xV3��"�~ݨ��d������e����H�,�~��;K��Y���&%c���'B����u��祖�Zm�I��8O���E��dM�Tl�l7��p)�R��ZL�Q&wg���Α���6�=Q��5W��s&֜�� Ch��B7Zw���uM'cZP�:N��U�)��L�=kKh��u��"��k���(e�d�օdy��6�6N&����5i�Q���"��"�c}�[��A]�w!^?��'���R�6���m'���<ϫ��9ռ������z�a ��<�|K�?�`y��h�&./��Ů�?Ҽ���z�"�?�D�͑h����yCxޛ�f�ϼ�?.2�Q���DY���bh�ͯ��apx�;����}��[���\��uN���!u�[�F�n5��W���hB�Y�V�[,7�>"�!��s�;��^�����v�vJ7�z8]����08`v��!���=����Ç� =��            x��}ˎI����+�S�A28+I)e��:S��(p#���ϊ[��|�]�/�Ԣ�r�P�Mm��Ǝ�{�5t�sӢ�J���fǞ��MY�F�ޕ���%��ӡ�O�����q��|��<�E�'ɿ'��*M��/���[���f�Y�.�j7����ؙ�����g��N���lk���I��'����7��V�l�zv%�b�ډ����hz٭�
�/۟�w�i�
����Lų���Rrv�7������˼c����ǲ�j[�>�㯲���`�CY�~����jz+ZS����~�R��M�m��M��i��#�A_w�CW��v���(����N��d�'������JϞ�j�EZuIdNo&�Ӯl���{�o�gO[�gU�Y6�Vήe=>��AH��[Y+�<���?��h.���k�'���;o����^O��E��^�8��:��'	�t��'�{J�c����X��5�uQ�{�з,]����e�ۭ�rE�xY��ͮU�v��Nkɜ|�Y�@���O겗���{󂗺�F�Z���:��3-�M��]��'>���Z�#�pI��L͞�$f%�ӹ4��;��t
<�����;Ր��r����κ��� b<�E�{}a&����ه�+Ķe��;$�����Ri(��ۦ-wR܂����b����^��ŧ��N՚U�;�b�3^��l}��w��@>���;A"!!C�#q<���D�m���s_��V�و�eY�~(���| v$�T�P�lR�H</餶�ۉG�nx!+�8��7���з��7W�竭ⓣAB���Ӻ�?���x����K��-i�-����I�W$��Ͽ/�o�iC�<�>�v��0C���J�d���V�b�}(?���ٲ��^�C�m�Aö��c���n�{�_�iȴWz���`ڰJ���<�g�9>�ƺ�����خ���Y�i��OB	6�+��pl�zz۪�ٚe���׏J�[`��ĳ���#�S�g8r���7;Xl]+w�F�fW��M��+��R\���Z����Q����<�TC���&�|:R��h�{�hQ&i����a��y�a&�ʖ�q�#�O-vL��6 Y��C�H7����izqoX��6�~x���f��nw��ʫ:v��0reAv%�W�Y�p��,�
��i,~�$OJv���^C�� ��ou���{҄>Su��^C�k�HՕ]~�T��IS1��G�B��A��wS@��˖��%D��C�G�J}�?r��ʶ-	��o�ӕx^ʾU����-�Ɛ�f2�q��	��0�H��7=�~i�t-ލ�dTg���!ET�7�7[̍�dU�*o�1a�*�a����s�P;���eUIA���e<���E,���@���>�Q�g&�;C�����	~��4d����-��m��T���(xz��rț0��-&!�@Gz�"|���_��o>�hn!�L�=���oJ�薃J��)(��I��^=��*��O%�q���$^{���Ś7}�o���m�d� �r.^kR-3�U�Ž����.#RUP�"p�����0��$�Ȣ*�@���i�2�a�9�KB������S:�-��yI���(�ʪ'�������� i�)kH�d*���0B�"�����6��uE�iҗ+B�m�;6OaFl�_���%P�g��Ŵ@�3<rP!�|��Z��oiO�²�Y�����\\$ ��Ф]���X����H@'�Z�+=�K:�����#��b.#x�a���86�����[z���䁥S�7� ��p�T�$U!
'ۍ>�!�U�(�!C�s�o!�mIǅt�`BS�C��r�7a)>��IՒx�|�) �DÄ�Vl%��F6�+���R� ��Pj��Ӎ�� �Hkɥ���Zs\�[�
��1��U4X�t,�HT67ꧡl�?��t�&F�s����H\K�WY�C=~iD�$��	z��g�~���.B,��ܻ,!�X�@ߙ�a@3#��RR��c7{��bL�P�K�/T[���CIH���-������3[�����-���v�3h�b,��N+A�
�v�e03|��������z�]�?9��)��d�l��J�lӉ��Ā��e^"����F� 
}[�&4hh{���	x�&(d"N��0Y_x�Mh�6L��r)�#��Dp8��o�̮��|G����[���:7�v�iL�3�Ә��:��GT���!���W ��z)^UX����?�?r �J�{V�����W1���y[�vV{r��()�"�l�B���Zg���n:mQ�'Mô`LoY_O{����+?yN����h���sv����J����F��ev^v�#GA�Ht���{P
E21 F�iGge�N��f2o���'�eC�9�P $���s��G��y*.�?���������F𑡏�:�S���Q2P�D�% ��$�G;vairn����^+AF��t��$����][����g���x!���SJf��1|���\D�9<�,�r�:�=����'U�Lx����(�QD0�)�=��9�v�1�3�7)��'U@zm�����0l��?�E��6���tə"�?�E����xG`�eh�Vv���0<}�(Z�7�"�"	I�+�T�h?-�a#�����U#�����2���|�J\�P��%G��D~˄g�@��6��#���^��XygY�z(Z���I�Z� M�9/�DiB­Q<�h�jg?�1�`�j���<�!��DH�Bv�,��Βg�86 �|�jO.#��@�Y���{ �J�y����� ��(N���:RW�����b���~hPI�],��-�,V�*��a������K��d��4}i|���4�4��eE�~C�7����Vm&��{��~�L��t�zTRU{��{CC$�2�F�Z\kF5{^��L���0�#(ّwv-Ml�d���F7=Qj�D�#���� �<��$�A����]�4����9Fo-���o[�[�Q��n�0��"��
:y"A���� d8��0Y8 u=ܪF[�2q��H��jP��o���7#DS$+Bd�i�v�AkDv���3���e�G]Z�qХ��W�'k��]m�>ɖ<�Ģ2��ҹ� �a@�x����C�yh�+��H��U��+@���BKį1Y�N�K�ƴ��0ӆ����H���6k.I����7�oB68�ひ6}�9��Q�n������l�%�=�82(�y��G�$+��X�)1�);�r
߾խT����Lyk������0�E���T�%*LťPu�`���9�Ti�lHɜՔ���x:���{��3����H��0�'�6&�[D&�/�)���1���_�ˡ�=*��.�J,���u^e"^��	ɵ�~�J�k��"ߗMˁ��Ayϝ�QA��o�X���(.���o�?	˥����bID���F��a�{p����~��e+�3 �U:��\� ��eW:���gv��v������(#�Or �<x��Y ���)˹�$�`�����`���m�gXF:j ��U�82p%����;�{t��Ex.�V1�� T�UN�Hn����y�e*�`���"�Jv��qG����2���Bj�����t��,W_G���r��)��[�i1�H-3��1� k˕{�e���sϼe*P�.3:�}y;��[�0L18x���,t��3s5}W#'
��7/�Z��S:�F����tL��C�H���(i2Yu�BD?��vE��.�مz`/A4D入���*Wm����~P5)*�C;bi����+�+(��}��"|ygye�Gy�0�R8+&Gؙ�)���>y+2.ZB�IS����0��P�[�-|k����k�k"�� g�8���*;I/_%��[�1���V��CG�o�F��ç��z�K�f�->�����,��H�����d��2����dMGz����8�񜎽���D؀ B��@�p~7�A*#Kś��A�(S;�     �=��0_�`�<��8���b	F�%Xȝ��	o�ʖ�S���^�+&��yo�ʶ��Y�ٮ��5_��e�J5�Q�\JF��
$�Ұ|T�&3ۗ$�W㷺<����t��=���6�rl&������÷��^�:���:�S����4�:&�Ҧ�m�0�����w����uo\*���B�kv�wƯ}FǪ��"���0�[r�M����W�l��9Ep�a�^����P�r�o2���ʌXv�Ҏtt0v�F1h�c��`�UQ��i�g��Ck�#���"~;�=��;��k�
j�����-�Y(���/���mT��<���
�\�;�
��S6�ś�0�wq'wܫP��L�c�x���*Y𝻁��`*����9��cw/?ʩ�Ȗ&��~��՞c(�j���첚/�"r��V���-����B>���?ۛ[1/��.'��n����v�ӢcI=��������D��+����߂Q����Ѩ�D����?W�ե$5lH� ^���B1{�1:�����K�§�/�������-S.k��:�%�ak1�ը��� �-hG����q�-��y�����^8Az(Z��`���İ�{֞.]2��(``lB��'�a�g��.3��ĭ��.���"&���U�k[��-<+��+��{���6#�������a#��ɜ����z ��z������[�����8��6����V��������8��ktĪ�;�}q�D�Ȁ�8NȦVz|�����yV24��t*TɅmS��aK>}l|�/�D��-�LB�捗d��'z����Co��5t������̮�/q�,������!�aZ@���e�a�Ro�7lT�]�'skS4Y�R!>fL�&�Ĵ��"�b*?�Ư ,[WZ� ,�(�$�z���mgN�	��8[ɲSHƝU�'�Bk�
�k)Z�)-Ȁ�B2-������M]u�!�8YZeȉ �-ș N(gNOs�-�9��v qY����)є=��U��T�8Y���\�3{v(9���\F�YK�0r�I� ��P!k�Ft�������HX��*�x��sQh���D�G"�F�+6�3ۢ^���{�� }lQ7PM�Hӓ�=b���Np��ĥ�皒w���?0B�ɼᚧs�H�t�<N����y��w���:�<c ��0��� Q�}\#hQ����K�*���V��� 7�;)M���H�R�b��Ӻ����͞���)�nq�۹����O
c��	2r��L�F�-��:�H~�~��/QC�m�4�YB�HM�'N�B̔���M�{ 0�DI#��a�|���b)>�����f6�g����ӫZ�R��l$!���խv�}iH�?k�2�r@+�[i��h�������QPz���� ��[�����gC�fIYw���&e�m?���ī�lJ��~�B�P��j{r�
KL\!��N�{4�����x����;O��,�߰�Ĕ��Y���fٯ��Q�B!�:z�����XF$���2"���rIX����>e�[&	��̯�K�,@���a->�3��@,3A�������H�N,�c|�>�K���}��I�;�������՜���eO���D��-ʿ��w+��"X2~5�(���h-��� ���U|Dzou��#ΫA
Ê3e[�r��������A_1]�'��G�sl~�O z\-īMَ���.�����$>4S�������j5U[��荸�M<�K�p[�ʎ#t>I6����=Ӟ��b��]��%u#;�tj耱_s46ўY�*46m��uU�AUMz�9u��a&���,�QJ@��z�BL;��0�:��E�����P+����h���,��P�K��y��K�z۳l!P���@c��(�D4�0�)[�ѧ��0���$L�˔��I[���C���M���/��5�<�(v��G���5�	n
���̡���HNyO���Z��f�"����'ص�d.A�����I��ծ-�a/]�T��yZ�4>n�T��U�Q5>�L��t�f��	Imfm��D),��F��uW��1��m��[C$��N��H��W��d�T��%��-�"��Е�s4�"���*�5���V��Cw&	te9ܲΝ�^�u&�s�1��Jh./.,vT��)����	R6�ٔ�Vɜ��"�����������w�-��<"�Wm��1�F2���n�T �<�
Q�]"~MD����d����~��Qj=���u� }�2?���8n�S{�=O�q=��)T���ǀ�v ������;zpN����-l �����r���i�+3(�n��F����472.a��M���\c`1�ܔ�����8Bɶ]MS�lו��Gs7��أb�MM*��@�hB��l:~�0�7��O����7�|�O�#��P�I��KR�IĐ��!�:���2 K�Dtv���#B��u>@Nx�4��+�f�)�潿}�&�-�Y��?4Z��؁%S���U�`��+�y� �)��c���5�<q޾QH���	1�	fM��=�\=�B+���T��WDc����f���qd��ɧ��A�a[���A�}u\���kҳqנ���Ħ����*�?mN8�MI;��^H*跔�;��g/�G�Q�`#"
fT�Β!�#�A���g�m��t�-�/��J��K7lp/��A��`��<�w(��fZ�Fީ�OB�s��CIޱ�Np�5��(I2��h��h��b��e�a�$�
rWj�����U�Il�����W��ܱm�XN@�%I0k]�����<6���$��W��MT�x�MTs���������\<��,�l]����և��d�����$��Q7����``v�-! ��|�'b҆i�1#M�h�d��K��h�i���<��2�>C
��l*)߷�⁑��R�����u�Q0���C���;�;`� �4F�Ӷ�W[n~�l�9H]�&����������lM������L'��*�}�<���oH��qIK��2��$��.�tIF�+�̐��ux*"f���u%�1y��L�sɳ���D�Ho�)7��Uwzˌe,�	6γ+ ~�<��wL����\<ۨ�2 ���Ґ@e����^p��b�/���ϒK
@���"���ܤQ��.s�F�%Ǆ�;�j�	�l�P��������>破�lǄm��/n��;�Q��F!�$�h�ݹHʭ%m(%�ڄ�����!�C ��)B��8�L�C��1ȯ�1q����k�p���µ6x>f9��U��ب
�taŒ�|�ꅎ�F�����)�������
��F�����Q�ħ�P�D\hCJ�#[�_X#�m ��Dk��4���������%4]WS��t]��#���&���S�?o�M�T�i�s�\��Ȋ�t]�����2sAz$����\� F �Z��@�ԗܿ;p��!�R�d5��	H\+Lt4D�իa7ୢ�,~R0��*�;{��k���}��Ⱥ��µJN�i'8�t�p�3���MM��6Лv!/�#�7ʼZ�68�iW�I��t�/�P�򼉏�#�̈dFރ!=^������Ω+w��މ{rÛ��� �AU�*8����<�ǲ�β�|��Z��6�{_�����Wߏ���U3��M7�S������a�5���A -ѧC |�a�Y�O�Tcs�v�+ދ�M��}R���}^[yf1���xpB.��j�|�N�0��W`�Q��ieN^1'D�fK;s��}��5.�3t�K�J6�I�Ì��b�Z�M��$P�j�jW��-��<����4&�E����z�Mv|�Ɛ�ɣ��3����B�_�� q�T��_R������N��UOe݅����s�0���]�P[s���@�`��k�8{� UVS���@��X�6av��{4*�uޔ�d�¼{�BNoѕ�uzy��RZgv� bc��;��HOݽ&g@�[\���*C�yc�*$����ٌ��4�H�8_�)��e�y$^#jؚ�z9�-��qD���w�� >  y|��V�FN����01I�x_�&������]�/`|�ol�"�I��_�]��B�)���0�WT�̷Lm��t[`�jc�w��;��|%���jѨ޳�j�������x�^C-hg��|�zJ�}Td�����eJ���*B�h���f�0����%~�1���"�����Rϊ���>'X��q�1�ˆ�pxP"^뎋-��g���s.�F� $��J[ �S54��FL��H*��SGQ�$o����|I�۲��鮉�-tM"�(���#���`��Ə4��;��ZA ݌[k�g�m��5�3���z��|.���7�y�xnn��:L0*{{�9Z��1{�vaI`��ل�	�����V�qL�v��-SDcaw��q"n�F���L��#��3���eJ�M���Qs��4n4�΅�Q[\؁�T9ש-O��M.̚�����2�V,��\�[^1��U�b���$��&f�@g&�!��gȩ�!���9F���h��!��˧�\|D�_O���7��ac�A�f&\5�,r�w�I��a��:���2��εax��$���w�����y� I�c��r��l#�����M����V�H 1w�Y�)YN�A�7��V<c���ƍ������u� �GŤI��E��
<\�d�F�[��O5� ��Y�8�b+C���t.^��#[4ݘ�����2|��iK�oO��7W��1z9p�m��8L	m��8H)@��D�x2�Ƭ2L~0��2TNK�6<hL|y�e9B2��3DӅ�N�Qr��M̱7���B���9q��&�q��=���ۏ�a@Z��E��n}�(�4���iC�f#��A��#���t����j����gn?��!���͸�wU ҍ;j(�������1;@���"�h����Uh�t婵�]y��Z-[����u7��]�HOj���=b�S%W��y�]�<�+���m�M��E�9]��
kY�b;)�6�e�Cs٫]#�4���)�
�"H���ѡb��}To:�h������,��=߽2�]^�ƛ�W���2�/A�뙿W�\�r�;C��e4�J��:���V,��Y�Ǟ��V���dǴ�[&�c�#j�q�����Z)_��g�#�c@g .u���8�����|��������7��ɳlZ�m�$�ek���L��2|�n�_��L)h�s%G�`d������o-����s4
z��w�3{ǻ{�y�0M����-,a7�P��ц���T+�B�`B��yI�CS��
1���>�u��bW�q�rd�5�)G���*��i3��ݡ@�f�4΋a���H.��^x�f���?%��;z㎑,V�B�1�jo0�����H�\MqO;���$
��Պ��x����6�W�.C!w���7��Q�"�N1�+Ē�ƠUoPxHn0&�0�g�i���q݈�T�ke�z�hUx��o;3x��ogO���RtZde�<j��f�x3@�^��u�@����Y:]��M;��k�Ȫ&V�g�-L��'\�j���J���,N���s'���(N�3Yp��ޒ���B����G:�(��d�5$�c:V�8�)�fk3;��]�mu7{6�
�n&)�	�9�M.�Eய�.{�V�o�d�jKz�Q눯$D�.���7�6��Iָ;��Ȥ�񑼰N7�3mVޏ�SQ"���댯���s��לo!��:ѣl����$?l�ɷ�-]��,[��Ԏ��`8˖�8!�M�/]��g���������}lID;��nB]������K�ws�L�*�I�fź)��Y�vΣw^f1'pԛ��ui��B��k-<���_���w�xE            x���i�<�$���s���}����10䑟K��{U��Qa!9E�X��)m~j���J)5�����>����i����7��7��'��[����O�����'�����N�k�Y:�!�O�j��r^�n�����l|[<r�Qk��c�_�O@W9A;߶�OY��]6^��n�S���x�O�%���/��#����(�۰B}�6���-[b"�	����?��y�d�I���'��+�^�}Թ�e"���i�[ޔ�]*��YO��[!����{k������(��ic촸k����u��?��'���I�����O�S�_&�؃5�^Ҵ7ΟƟ����&̾��}��Jn5�B�B���CKU2>����o<���Z7{�̭�n*�<�؛���~]�ə;���A6q��������[_����� v�v`��X�F��YGo�.�]�q'ڧ����7�yL��2��q��S�hu,��B���v�V�{�5G�C��]���Z�{�m����3{l�Cs������n�'ײg�_�_k����O�~��v2������}^�I���5�VV��"�L������7d.���hO��h�9��ˎ�,�m�]e7U�칥n+;�8����n{���7����fގ�~6�j���9X����I�j?��o{Z�����:U��\ݖi����c������vi�����������m7^I��-J���γۇO����]�Ε�.�� ��'ۛ��v��`>Esh?n��7�}Ց�����M�g�"�_��ټ��m��p����Ǎ���3kl�����y���>{B@}`��Y�VS�mM�ןv���^א���l�q����~�э;�6sK�z�<�q�92h�����@K�'�36=.�Ku�ZS�� ��A��ǻ��RR[�an�c�ƪ���r��W��6Y��ۤ������9'��Ӗ8�����a��&�����S�g��c��Y;��sھX��|�����Q����ٞ(�	�'�����-��^�f5������[���'�~��A����k�K�����l<_�}�Fn��Tܣ+3~�>���T1�d�ɳ�l�b��~��ee�d� >�ۭ{3b�|/���{ꈧ�?�xf��'8ƫ͑�@bO4>բ��9|C�?g.ʰ�l_�M�9�q��½�h�֪ۗ]ñg�쮽���y��^����gWn�Gn϶` �����מ=�AU���;��"�۟t���yU53û�{�]�?1l9c�F�,X�XmKfn���~^�I1Kn��Y��i��a-(0�9\�Ď#v2�+8A�Y0QQ�*B��gw�mke��]}~���u<C3�p��kl��F7��38�e��N	.�I7��O;�f�+4��ׇE4�[����ݫ�Avۛ�����)g��0t���ԃyf��G3�8�7��0��@��X�"������eQ�*�V��8�x羬F�m�]6�l�r�yg-�Wdlu�.����?x�,Ɗ���Ha	�(vyMbo��}r����UV`u��g0��i����g2����x퇍�,8�[�?�ۏ�i��ʌ�l�z�Zf��y�}k��;���+�/A;��G��̂W�g~�Z���BE�8�t�v7(]Þ��ՠٙב�؝{ܔv��ϯ������&@�����jFr�ߣ� �}4�1�9��aAQ��V��y�����j�c�{��W,o�T1�jkM79%��\`��dD.v�$�b�B�h���˰���͑Ww�:n��W�07�6�T���l�����:F�i���7�`�������O$��r��́=�b9�ł�Zy�jV[�p�es�$�]�v���b.����SHl��ؚ���m��{�qҴ�7�h��=%���ڽ�F^��W�� �~e��6۽V����Ϸ�=͝h[�i�\�o������pN���Uk3O��>O��9���]7�eNZ��0�,�=Gf���<�[ˢ�4c��h��9}�&�o��g����?����g���+�^|�iJ>;�ol�����5sg�⹑j0�mk�GC �r��<.�W� ��V��sq G����L�>4���X�kG��=�Z�~5�`֧��3!OF���o��DM�7�_���#���b�R��&,g��S��J�R�:07���%]��mk���5�.|��2"J�Ԫ]�Q�-o.�8�W��4a�6��i� �k+�ܮ��>��y,�4hB��a������c�m��6bW$sa@��Ո�9�;���H�߹��C͚=mG��Hd�����j�l��W�µFr3
3�n�^��u��TA_��~!�&"(��ƌ�������Wޑ�ͅt���}�V5.�b�Mv��כivÞ׬z̈5n������s̘k�F�v�-�h`���X<�{��,�iW~+:�=�Q�r�e��̍Z�>�m�����4�܎s��w�dm�G|*[�n��V�3d��+���$lX��"�[�x�m�i'���>zv�s�Q���|M{,��H̘)�-(�ҟA�efh͉���;>=��a�|�s��Wg�U􆺼1Zd%
�5��EW�À���,�3|��Ɗ�"��oV����J�(+7T�>G�9��lҴc5���ϥ<T�xM�1��3a���3W���;~�@����>��s3#�تb�����^��]S#9Rxڑ���^-+�e�ç�vɝ7vg�*!#Pq��$7��.��]�AX�-b����U����X�֚;�9Xx#}\q>�(˙),m�!YN�A���a�#r��gwi�Q!���7���,gZ��jTA�4󁇲
��z��XV�'��kY`�p�p����� o�\���(��cX����k��6��$�����n�p��-a�Ta*�gq��n��4O�o�<殻{�����d��35+Ȉ:�B�܇��,kă�	��S��s��������݅�9,8�$�q�FR���8K-UxPL�,��9���*m��ő*��I+A�#bί1G0��y��/��=�vʙ,6�	�G�c�Ed��eϹ�db`�}g�2�}@%`-��"�g�'r����	�'d�ϲ(H2��c��УR]�Tb�n�$��H$�d�:����.�T$����}"�n��2�s_?{��5S�/M�k�y>��Gꯥ�_�c��s,I2��qٓ�D�`��1h>��[$�dFʕqQu���W�
���̒��o4���{�oBuv0��օ�J�Ŧ��'�8귕C�y�D�ތ�]����0WI�ق���*�B�i��h��\��?pT��=w�Zs��/W��a���EfX<����g�K�6Ș�_�~�v���ʠ�I���s&>�d\��ٛ�&φ6��>�3��t��T�ғ��b�w��H%�93c�d5�w�輣���(����lP+��
X�nimnk�>�"�y����"Ĭ�k>���q;��`���;��%G���ܑ�J�R�\��s�;���{��P,��L�)��G"¶�E"�����+a��`��iF�#Q��2EV���j�uV�P�����^ŕb[��kGn��τ�T��QfZ��!Ѐ�.Һ%q����=������&�����;ۏ��8�l�М���ZK降ю�
?��K������i�re�ScAvc-��ݱ��N�V�La]�om�v����
��T�`����,hu��+���N�%8M>|�'��J���`u>�O���Dy�?-�n�X�>��Iס��Ә�`D��TU��=vD��lh��� �䕽�T����B��\�FS��F��u���2Č�T�H)�b)������1��-J�_ZuC9�^gfс���a�9ۖs�?Ĉy)�#ؽ�@��5�g�7s��]'�LA��1m�53�����69���I����s�����Q��t����,u?cq�.Y����m*��F�ˢ`�A&�HcZ��X�D��������c6�"zIJMW#�]�X��ka֪�@)�懍1@��ƿ�Φ�)�� ��>�O���q�qm�Y����%��4���zY�8�f�,d`Ѥa0    Z�&Z~VBɤ0f�&�<�i��m�j�����wX��AA�v�#dA���~w�TA��%F'|�"��a�/hğ24�x�c��d��oT�*,�k	z]	.=�V�'ix]<;V����7FE՞�<3&b�ܪsĻ��mq�*�?��n��N>J�a�����nQ�D:��n=OǞ�R�FrU���dq	^>�}@��v/i�<`�\��4}���~%�;oXf|.L�H���]��k��a-6IOюS7nX���>ǯf�Y��z���.��E�k��AM��)O/(2��UT��8����.����>�Js��`��2_�zT����E�j$*��z�Ґm���~����>n����7"y�o`��y��4�޽���c�:7R���\�!��Xs����SY(<�F�uyqi�
yab����TA�����g�Z`c��vI%G��1Jб�]3L}|���x�����X�ssn:X8��]T���g!�!�YȤ�"�[ٞ�<�(�>��ʕƷ�Y�E�λc�vOu���Z����3>�0]��f��Ug�ȡ�@��e�$��7p�>��D�@a�t���Is��nÞ�{J���f;����3�%X���mO�N���i�޶VqZ�����UYD��������T�A��Bu%wf�F7:JZ�E��'(�Q@m.0�p�S�/=�K]��v6-v��}sy�Ģ���\r�k`�d�Y|xpu�'>� ثI�Ї%��E	.9����8�Ğ��"���1C �Y�ח23��h��Fs��Wzy#!RW�B�ҝ��P�T�ÏX�T�1`an�z��n���>�Ya'�ܖ��GH�\R��� ����yF��7�~�G���˾���h�u���W_�G����B���a �O���,b@�x��Cn�vr�y�v����D���K��g�	L|�U�<�0���B~
;�� �W&��!��)~��
���j?�Y��_���F�C=����pVg����WZ#_��O���ebW(p�J�:�~b��7�q[�D�9�g��s�/���>f� .1�˃T��ʤ�D��U�)�=�~~P�Gf
h�
�`7�c�n;�љ��(���7	�̶��V�9z���=b!��2��[����tq�:��<ߝ5�lp��7� �X���Iߚ�c�����_��?�`�=D� P{�ѭ�_Z�jw�l_�R��H㟠��"�ھP�4��_Yr���"�7��fD|��A�G#Ԋ���1�o|&��Ҟ{e =��x�>�A�?w�	r ,�G�W�4�mhJ`��Ku�*�z���Ğ/,:�}��4t���JQ���;|I�����J�߳��%q�P�Z��P�ci�Ŀѹ�^�P��{��j������o��+^:R���[��b�9��'�/�����￺v ���Y��V�
n���V[d�j��*
���%5r�8��G6}Y'��yT��C��U���x��04w��܆���Z�c��op�q$zS�^�K>[؋D?`�G��CA��/��!�J� ,����w�O/`�����QU߳�������l�}je��]�=Lj�/������H��'6s2������IB��� ��#S����	�B�/���ݺ�>o�,R^�~5�kYP�k���>��Y�,k��_�Y����Uf� ��X�|��Ur��p7�G��N<�\��j�7�n^��@SG}aD{�H�qs��R|��ߨ ��)��zڞ��0t�{�~�c�H\�6d���=��Z[�U���oW(�g� $�h&A��-��\����d�z%�����y�6�u	�:�Y��d*����t�H�.4��Y͡�������e��D�#�4=``�����K������,��.�0o�'
��9�Q25R�x�E����:��������i`��~�(�C"0�ь��=���:X$�B��!|�]#���Ja����+�������[��2���)Sꝫ?� <�j���Aݿ`�u�s�_[F�ެD���ֺ��,� �s�)�u}[1~;Pj�酝�Ȩ��"@�������V:�G�T���`%��Ņ�Q��u�7�,������Z��b�^��4/�����PW9��Jp X���o��F���L��D�����Z.D!q'��fo�w�H���[����i�*7����00!+"��*�{��3���|;������s"���XC}o,�'K����4�|�� *DV�|��	_h]���Db�LJ�t�Yd�"���n��2��I�B媅�[?�e������g��zT��\�l l<�{�nW���P�r���<l�;�I;2�}�"��{�+S�Z$ܑD�u6ldǞ�W-����l��_F��+�Λ�`�"���uߌ:�g�YD�y�-��*� �3��u��]�|���������֊�Y��M~ �z^&��g_��ؓ���!KP�Zye_��V�'$���k�I!\~�-2��̷�g;�G��j��8"��J��{/x�w� `ũ��Y*���o�D{C��<&��w�=]�N�*@ϒL���H� �@U�6����q�,�����_d�[o)k���V]��G�ۑ�뮈{�m[���w��"���E���Z�(s�F�^�<6�'00��n�5=���PbC�K4����*�\�s!�k��ڎ��T����,�"�R���5 ��ms�^��dX���00����+��S|�ZԐP� �܇A��dV�"a]K���U���Z���l"_��\}NP���Q����|!y����.M��g�J����Tb�qJ�Aʞ�����X�m��w=���"?g|/�֨�V ~�9�1��Ϭ����C�b�GN�\q���Qy���|���0����s�=P�SڀB�vU.�R<�~�c?E�#J�}�T�'�����3|�Σ����5���
�t^�M�3���ٳ���擎�y#͍WS
��#��	����4C�p�\ף
��x�r�w�UG���3�{g��W��oW��S*HAE��`a"�~o!v���gy���'��:�����v)�@�ߥ���X2���dܥ���P��g0&�c�_����/⌸�EABS��܎�]"�*M$�z�`�H��K�%a�ӯ���s�]Tw�wG�g�J�����{�+�x)�c��!W��xmنd̓V�bo������G�/9��RL@=�7�H�ߴ�=SX[p�o�e��k���r���;���"#�)�S���"V����஛R���0������I���w{Vow�yw���g!�\}h![�T�P��u�Q�0�xUd���;�=^�r���w��s'�n�d��QK<����֞.�S3�+�b[��$Kؾ~���rD�k�=]�o|����u��l�rF�o�%R=�������Ni���G��O{h�q��������rGR�5�:48��#@%�+�"ъ6���j_Y��0G��k��ϧ#��o�sy��t�x�W7�p��r{c�}v��5��>g���o�?�x��#�W��W�'{��7�ӷ��3u���ʏ�^f�|�@ky����=���\$��6��#��cI������k|�^��a�[��N����fK]@�O���)n��E���%��h'd���hPq�]m�H��M�A"C�C�پ� n�"�rd]��=���|Μ���"�;"��C� s~�yO��ڣy��[Ԍ�c���xڐ:[��,���9~xcps��O�N��BRr��Vfם7�_n��hЅD~��9~U���ٶfY��x\��Z�(n���o�y�z&|-�d|�(��~Q��ӆ�>������؎=*��?�Av�y���7Q�A� ~�E,�e��Q2D��	=�w&���"hD�9�[�``1O{v��瞫�=K!zNq�6���	K�ɚA+Lە��h�w1L���t���l�c�;3�j���8���7������ֱSn�1	����B�e䔡'�����.�%=��9Z0�"�����K    N�9U�/�<]e��|�f�x4��p�m�{�pʑ�Dx��b��d�sa��	�m#�*�AAE�ͬ �"8�~8Z���ɰ7=ߌ��bs��M�QAHg�Iq��|!U�oҐ��V��}���iJ+�"4�>d��r+3���su�G���0ܑI����O��{�N�zh���wq3����m�0��X1�:�� 4$�����s�@���M�!���鳽iE;��?f�&��m#͂o;X|��݃:��C/���:�5��b �*�r��2����ƀas��?��G�5&	����L� ���9�������V[� �}FS����8l��-C�{�˛~�{��j��ٷ��0�f�ȦK�|ΰ���_}E��?3}��bE<�{�'�,��������~���Zu�Ie�x�s���av�g�c����9�>?z�A���=<=�� �@��n��ʼr��� �O���6�xH�t�v�W�`��^��	�\̍}��&Z��"�� ����.����@=�`�s��tG������D�������٫�Cõ�� l�4�ғ�Oh�!��������w�R���tfD�w`oy�v"��.��b`}���wz�^#�l�Æ�=\�'���^^�V��Tg�p[���	���v왯2��T��.���Iw��s�d���]mq�d���C������ܻ���T9G�����,~����`m��yQ� �?p$��p�C�9�J�}��������	���ggd�k^N��8��Z�-��!��Ʌv��R��]�>��12�AW��72.����3Pv��|�&!k�h�v=D�9Œ�����p�=[�kh,�e�`��>_3�����0{�lcu�8��� �Y��>K����Q��]�>~4�g�ų����}'Zl��::��stD&�.��/�z]��p�O��&���Q��e���6�Q���y��
砦X�s�`\�cQ�)f>ҵ��0��R>j�G���/>�B���-B��QwN�va���1shqIא1��(�\�rGJ�a�5�Q]F	�y��T��sjz����ߑ
���m	}[����	l����ʋ�χ�՗y��k��2��A޳�j�����ΧR@��x���<�|���A��Y)f����	Ӫ�����ԪܸT��s�p��2��s:"� c�Cx���e��-��7�>	>0����R$V�^�f�"�,8��׫W+S�h�����s1a��/�P�����sfj������L��ա��k,z|����J��>/��%���P�L"5>��� �N�p0��w}_G��;r�w�n�ϊCcx�I]hc�:�6)G�U���sw�B?��k�gͼ)]�1�)��\��I�)��@GʢL;��-�b�Ǖ�j)��˸͛U4�}�"��٪�,���6�f��ū�>g�G�⠣}[s�:H����ע�y�Rd;f~��*Rz\�7.I�p��5�ѳF��'��~,��9�ׇ(!���Z��3mp��,����s�7S����%PF�I�{�He�1�|��M�D���"a�ҋ�f�2O#��G,�@�MD&E��#HY�9�gW��_T�c�79�"��ƥ�s'�|f��K���{ޖ+��j��rӰ�Pq����~M�x��2,��^��k]�Bjo��$�5lǊ��zh�/R�h���;����y����5P@�y7/籅�_���K�E��\���@���=g{�L�R(���:����C�`1���:�F��ڧmO)g>�������5V�s��-@���L�-p"���3����{þ�'�~���s�~��=GM3�����w��=潚7I�Y����=���� >��/�����3(�S��)*@�	3�t�z�����k���>6�gz**����A�8�A��w��bYT��$y����LӘ���_�+"��[���v�#��/|�ph'� z6q3�Ǣ�bSD��>��s)x��B����n:��"����s�-��� �@���+o�3г8c,RR4�Ϥ͒�;��������H���|����jlW���ށc�=ҳ����F�Xg��?�t���k�s[����E-�,{��_xwne��y�	r}�h,� zMpq�Ԁ�0�9ٵ;۝�3�~^�z{��v%J*����#��\w�E���=_��^��_��"Uxfm/�tb�ά=�����(�\f���ͧ	T��'r�������J�9P��r�C �܁5Y��k��2ۗp�sP��ˌ��*�=ێP��aŌ�U���x��\�>�]"�\�������	wC�/eL��l�����v5�����щn�צ�ϊg�)�����7��
�W�]��Y�N"E4eY1p�P���䞿��tc�3/�xpy��-6h����\�,G`ϫݽ��gN�����;���]��sԍ�O
/���<q�} ��;ɑ���^o��D�	���k�όA�>|�����oU��s~mvk"��[B���)<���;���dqm�}�Q���}c*
�Wz����s�x�n'�[�7P��fI�=ok�P;�΃y��u�P�<�y�ݡˆlЌ|��ƚ�u��)�/j�����oj'������,�N��fy!�|V;�ds�^���lϲ�E+�L���yE����� ZX���*�$������^/C>W�'�t�����S���ĊK�|��HǞ�ڹb����ջp��Ty��n�ϴ۹�3�`���>I�೰�%d�ZC����Ğ�%f�уT�D�?��zm��o"h��^��,��ۍ��V��x>��\�?��Pe�����l����I-���" ����K�����X,v��Ҝg4-82C��A�0�j�n~�$���J7CǞƞ/�!E��Lg��uˋ�� ]��fB�9��\��Az��s��Ȼ�;��Z�p�ꉶ�S��E*Y*U��E��M�֑ǥZ�}ۿ��D�,2ݽ��cW�,�SV��B��s�c9]�&B�P��_�g��H�{#mW�b{�t�.���C���V�l�������<�oZ��#���q}��������;������x�kd���%�0Mȅ=�Ca�9Z�t�� ����Lz�ƣ4V[=H.j\����S�]6��3kӥ�bJ��6ib *��VE�Z���c$f����'l��<(`}f%B���i,Ȇ:�oϞ|XẆ�����B�m]�zH���.R��bQ�qV����>�H�c�P)�-���OVT�U�f��BDS��j�x��4�gٶUޔ�|>!`8 �\XYA�(O��$ȸ��[^5?7�{.�o��gR�����]^r�,o��p�QIQaت��F��?��8���k�LGj'"w(�=�%��~���$��Y�,*"Z�b�lT�<��-���G֬ bF~U��hqI�9Ubϥ�u%��={�^��
���F��I�?����S���f�-,~�W��g��������]P�`�����]X��k�l��z��C�8ˑ�ߜ7=�E�}�ٮ	���bBϊk+�p�2҅}�\^d����A7Z��șfX�����Y�>��:��"���X������:?y��s�m]Z�71U09E�r��2,�Y�*fcy�_1<�&	O�8��J~�ut�+��-9��F~�'�Li^!��Q����!����������fӰ�#��&�[t6��K�;Y���o����wD���+8�#b-����{Ђ@f<)�٪��"�eζ�6�u0�cϹ����������<T�X����tr������Y�E7��y�z�ϴ����W̒}�D!Z\5��Ǳ�#yM�� �[�	^<�xo9ϐ��0�\���C`G�"s_�l�`w&�2#��E!��&p������Z�l�ùB��i[���@���>����j���-R~A�/(--LH�j;A��bɊq��Iz���J� ���3B^ʀ�%��_j�M-l��W��F�I�_�)�{?͚�d����s��j7�"=��ѣ�C�Ғҿ�_eJ}�`    !��+5��Jy�M���gC�Ǜ?�bc�o��ϰF���I���!�
�b�KS�zu�]��SU�`�G�G�v){6�T"I�J-�<�_i��A9������w��;If��VX���ϹS4���1
����R�I$�vd���>G4U=v�{���+�{#�|ˀ��冑�sTГ{T�[�?;r�H���4��T	�q_�|U�{>��vN
X9�_R�����>g�w.Wr������OQ�4�Y����J�9ۮ�soG�/�*;��9�σ�v�:� �#���lz>U��L��#��G���c@Z�� �Ŧå����^��'��"�ܘ����#�秖7�^���z�
΃����C�W��j��;�i���Dvy���X�ڑ���X�س	�=R�c�U�ʁu��*;R�z�D�ou|猠�7�x�^��\����>B��C��ܽ�1���j9}������>uevk��2�0��t�8�7�)����!�Ʀ�C��ؾj�?�q#��-��R�7�t��j03BM����*�h�f�E�C�Emz�h�`T2SzN��+�Ϙw��x�Yp7�DB�l��0 jC�H�#`�ۇ-TO�=+��H�6D���c-L��)�gv-���!���١�z����\��f]��O�[������g3`o*��۸h��8����OW�����}��+�/`r�)z��,>�ŏPrrUq�[�#�!�$�H������3(�xtW��;��RD�=ʱ�艩��e�ی�c�\���������Ԁh��;p`��¡���
������N3��"��_>Y���>�ȈV�=���R���'�ٮ�+vwV��"۪�pj1�~W<��{Nך� ���w���{�)�K&�E�4���>��;�L��N�BZ��������}�c��`�K1�!���磖��5�|�xTd���� }>�ʿ� X��ɧ���bL�����W�[�w�����d��w��[	o,h��-�SGY�-o�>ol�t��M�9˻g~�L�J���ë�ka�����_�W�K"��K�p-B�~B-�ة�r֚|����_$�W�_i�߁"��=����*���<��b�M-ݠj>Ϟ��h�2'���@�ق8p�H����6�)�����K�0s�Ъ�dS�F�C�.osM���z������SiF�9�|��.��`���el����^�q̄A�J�D���݌W�F�9�|$b��}�M����+x����`V�����u��*�-�|i���Fm���y�vLE�uF����Y��J-b��2��37|S&�f �rT�;4q
�]�9�+�U�ƾ��3U�vf�u8T}�p�&�+��b���J2b�o�J`�y~��犉��{��aGb��Qz�]�<���IZv+�%����cA�	~gf��?�N�חi"D���~,����;z�?��=����M��6���t=~�١0��ړ��fI����PUN�NL�ys�g��d��%�SϘ���)�C�"r
V>�s!4j���	Y��<��9�i8��	������ ���)�o��,_�?��	>���ڰ�A�)Bh6b��$��]��/'���a�y������_i�|�yb�������q���XJ���>��ݺ�%�h@"y�Q�(��0�+�Qtj�'�`:���Q;�WT��G4���iV3�i�=2�Y����ՙ�x�Z��Ȋg�OV��z:�g4���a��AM+���r[>�h8��z]���z��m4�YCEJI���P��;�s�T0�*�У�-~y����~��� �ٵ�,B[��@�뻆��pBE� D�\ ��<���+�%*�Ha5��%�P��E�9�g�q��~�}N�z^ce2�P%���3��V��E���s�R�'co��D��Q��^��=���<~�r��?XEۇwS���yP�,׻�왫ӂv<\ٖP�1������$G�+b9]��e��i�u\����_������t�Cf2�۰{p�*.�n�������u`����1m�)$\����W�O� ����M��H���Jg|�)z�2�&/	{X&�=/�����Ə^�jiQ��W�����ۼe�Ϭ�����P0q.ra]`e���V�Y����\�1pdh?�s�>R<���̝��Ս�;�������WV�5p�x�m�/;��H_X<yDҌ5��"��J�?¿5��rx5��0��%/��ir+`��Ym�~&�"���ʶ��t=�_�e4w���/��Eۻ��~[�:�!�y�F�����hCׯ砲��.�ZP�H�����o�����t]�@+��n�S'T_�\�/�q˰�'����\@&��G��Cyn��=g���0�q���b��$�!oN'F{�,�S v`ϬM��� �':HВ;��a�I P?�8%M�	���ǖ���;�6�ft�v������1ݮ ~/ҷ�d^�:EMkb�$����*Y���Y*��
��@�f��	�}ٲ�6x�r{�=��W���L�7t��;��3�>㺎�;e���$�1����R~�my\��4�d@\r%)�fc-������ц�6ù��n�Os�_UP�)��)]��vN��og�;mբ��ak�Sӈ>�{C���O���S�{�}�0�)
���=�ijZ���^���Nh���W�IZ�����U��!G�h�}z�$q\��dM�z��<悿ś{;�,�d�q5J�Qk�Ic���g����W<��5�殈g�sۀ�}�$��eHv6s\��߽�&�.��\;-m�q�8ZD�9��&Ɏ�di�ﱮ2�9� ����ҙE�9Qڝ;���ݶwi�WW���M"�\�����"Ϻ;\�c$q���bCT?���� G'��MV���߭�
�4�H�b��xH_�S%�sZW�k�vo��ͦ��s�Z�T���wm`�O%�4��$�L"X��jp�y�Ke�Jg� ��hs1Ւ(�Z�K0\�V��B�o���%���+W'h�!�.#��>Ii&17����/�RْU��`t�d{n��lTB�l�(��jS�gJ�z.�h~ci?��r�����fD��i{d��PgG�މ�9�gH�W_ �'�Q&:�@�%�m@夓F��s%y>cB�ÜC�E�M�ԟ�+�/K/�Þ;2M��Ha�E����>���)/�ha�ˌ1A�2���\�}F��'�O~終w���r�PaRK�-�"�����v�����j�֘_jP��ޣMomɪ
���	�\�68�ojQ�"{Z����,��I��)��tטv��0����W�� �}��pa�2xV����\����X ̀��Z}:��UE��i�1o�3�#s�QHe��lLe����d术9�]���.3[J���/A-�e���Ū_50����/���`�er4�mi�I�#l�rZY�֮r	>��a�#�G�P���Z"_��h���i.&�a
7�ߥF�e���@��i��#��x��@O亽1���K�/�/��v�h��L��Fџ;ӎ�P��>���$���D��=K���M49G��}�I�(a�U��� YD�0=͠h���4��E	W�F�����z���b�\j�wE�F�n����?�����9ZE�1/�A��p�B�Q'x�iFBޝ�3�0=�y�p��bU�Mw�Jd��=g��}�c6�8���}����P���x� Z�_����ݨ�(��o�ݰ��f�:�/ϏX������ X]!��6*Ɖ�B	��d��q
�.�@��'K� 0�RpW%$\��s<
��,(��9�j���`�tF� mP��fjt7��Mƽ��%���۝z\	��ɻf��ʾD����t��e5��J�s@����(U^��+j�B��1T1�O3g_��K��%�~<+�µ�7�%��E��j�y}����C׈'���c�����:z�Y�]|u�ƚA��9��35S�:��6�W���nR��W� �(�ƘOs��&���-<ӧ�V�|�ǡ�����8D�    �aX5>���@T��<E��6P�l̢kl�4�ՠ��Ǟ(�)�2�=�>@�R�]#�.�C�pXJ�<Ȱ4�W����C	s^TSң{C����%�M)!Zp�K��S���,��~�~ޣ%=W>�?p�!T�$c�H�WXZ3����Z%yƼ;��>�KػH��B[���Y��B	��9�)(O��ru����l��9�
�}	��x}�a4Lc��lK�W���ύ�^���x�q'Z`��H��W�hA�(!�0� ���*����h˧�a%�
\<�G�`[�wT�F�wq�y��4J�<��+��R�U�v�JssG?�,�m�D�q�c���1���0�,cR�z���J�?K?s=k( +����`����g��U�O���8��)^��բ:!�7��m�����"I�`×K1�E�`uo�/#�W�puWF�]�3s8�Z��\цS�R����i��(��'z@�+�5Zr��f&�ĭ���p�E�P�b�m
[�ӵri��P��/�֞u�A�Q^p�f���{%�WS�Pu߄j�햆� �o�����n>ӂ�:�J���X7y<B��A�Y�+�[\{o�"��o���B./t���ܠH])����U�"\�s8��Y>SJ_�y�o��L�rq��o ���-�.�!�W�}^<�V+����F��"�-�|3��=�AG�l�q5�:�	��j��~_���%D����̱w�u��=20U݋Pyu��{�Y�T9Ge��x���D� l�݀^b����M�J��G�f�5�[R�`A(c�t�!�&�P���EK��9\�6 52�U��D�;�]e�Я�T��T��eF��;s�`A�A|��B���'����������L�;��BO�i`�*���s��K�Ƚ��h��V,�{�wB���F��Ԕ��
�*;!���3��6�Q���*bUk�jrf�O,yL��k�g�M�����T͔p4zn��+���2D��7�]�>#�����y�5��9d��@�s��J��eÜ�K�̍pW('X�滼	�fv��3��>ۯ�ffC�����_\}��vg& >d���˕2�՝�3����y4�х|�����W:���Ċ�z�Zn�N�����xm���Ҫeg��W�c�2���KVi;��h��>Y�b����ɬ�7� &�fŹ�֬O��[l����X��.�ͽ��[HW���d�hf	'�gdz�EXp� #\��5�6�-�""UI��܉Wo�_J�DE��]�س�R}�� Yf��B��4�_՜�-��
�I+t��M�gO���7�!���Y�v�J�h���c%&�k@���&m�IW��]ϨK#Íю�zc������w�R&�R<7*��Z�1�pqZj�R���B�wG����GHU�a*[�j�I�,�-o�fV~!Z>���M-��5�s��U�b�Q�D�lA�ʽ���k;-����n�ը�3����P~*��%�b�jzk�#\������1,pub5�bs���-�¡g��:u}X�O#Sh�Vר�Fz2�0�o%R�*�c�9�"���T�_yC�iJR;��6v���S��m����� �tW�Ȟ��+R<�	����v��r�Z�J\#�8�״��R��wk�E0 �J$5�u�sYd5��q�W��5*��\JS�Pz�C)0�h�F� �rfssэ�MxA��8x��AM8�WViP�T/v��a7S��:��^��!9t�\��ի|p�o�$<A9���p)�U]��.���^~�a{A��x��J�7�Ku�",�B`��^��~�t�f�!E9��Ri���{˩�ՙ�A��Y!���wo��_ՃN�n���u[W��Ǜv��E4]���#�,��s���߱� ��@0u�d�-�*�B�KW��@��㈤@�-E�I�zم�n��;�H���k8Т���4�A���WB���`Ӆ�}^��jTn3F�V�_!��2f����C1��	h�3�W-�6Ì	@%$TC��B�x�E�A�_��;��	Hy���+�u�=��K����^k�Sj޺�}��vf��A ����sqh�~k��h�Jq�K��ȣ q0�.�P|�Qv�ʍ���-��x�4����Tb�{��L(�w����j� :s���%��l]zE���r+�n�015�2d�G�U�}���ͥ�+���t��gXi�\���F	��~U���f�r�aJS��H5��_v���T���R;5��_��
6�p��_�[�M�@<�#3�"���gY&�<��d6	�.�@��M�~y��0rݯS�/*�x<4-�r�5�]�]����+�s�i����I�Qf�>/���E�n�eٺ��NQp�԰��R�U��w��
�H��+ǦEj<�UqC�<~�u�+MJ4�p�C�%T2��=�"��������Q�A���s��w�q�4���R�+��^4�#�DW@�v�J�/�y�W�һ�p�q Z�ޫ�U ����F�bdT�_��.,F��p���dd�&z���#Gw~H:q�����tgޕ�m.\�Aۉ�����̷�6,p�ojW_n�6�Y=��)��-Z:�/�� ����+��9����m��z���P�M����5���̃�d'���u1�஄�p�"�̦��y$��ǛQ�V��6�p5����F�,s�g.[���H�:^-<&�A�t��aZ�%����H`�����q������M[$0��7<�c^$��_y��pe����������K�]�_-��.jg9�跔����I ໊�J�0�*��ѥ��J�'����	��9��Yv3�E*�V"|7C�{���B(ЂO�B~$  �{�ەx9��y#��m����͛>-��-*w�U��������7�Т0q� ���91����Y�^�wߒ{ۮI��uV���GU�l��p����|�� �^��Τ�ZH��-��c���`W�W8��ۙK~KZ���x8�c4.�5�̶�{�
�V�1��g~���Ke��������}� ��L�Dx��xubC��ʺƘ�`�h!rA��K�����|���/��L��l'f�����//%�b�n:� �ɨG3�bN^7[?B����O���d�+k��9����<�t��t��h�� �
��H�_--f�T��Ei�>c����UΤUZ�
��k���g~V�r�:0�DA
������P�V�Ώ�+� �̬s���.ŪL��d�l�tS���֙��ƪFA�Z�������D�Z.�����:�( �y8��&�o/K��4fE'4������n1('���<9d�56Dr�]�G���S,4i���o{2��X�heh<�gѷ����ڕ���-zt`��=�)?�~I�u��P�:`�v����?�����Se�d~��tQ�h>.ᮽ��֢��-�Ȓ�m����.8m���Z��m���6��a��X��.�6�`�Ga/@Q�F��N��R�?� �ɥ��m&��$?:��l��dMt+��D�E.�dQ�x����>�ZH�#� �j�D�뚥=�gt(!��/��Q;*��������9^��pg�A)h9:����8R�ңx�ha��Du�G��I_�ܤ5/r�=]ʕp��l��@T���!��0`��m��ѣ$A�¾H�#��M��ߓ�����y��#2�,�8Uo?�&]V=y������<��H��&d�)G�3����ch=�����d#^�ԑ�s͘BQ�X��	w)a��DK�VthaؕYi�������ܾ��C��8���.�I����ʅT}/?�	e=�(`�����	�Y5�v/G�=��h�X�+�ZU�.B\m���kш�z�wx��H-d�У��ڧ�����X(5��	�
]�@��Y0���b����@^�G�E1���eT��*[va���=E��]�Չ�p�������"��>p^����Hpu;g�`���7/���x�YUn���DE�ŗ��=�)@o���k�_:n�Е�-��6��V8(�    �x|u�"h�ʦ�R�s�I�1��A�x}�G�Dc��6_��J��/��&^�.�^�T��1U�A��괇���������p�τ=�+פN�`���[�XrV4���.}g��6ZM���9�WZQ�E��3ٜ��T��	<Q�K_�}x��/!���}Bi��KJ��c�a�a�3�D��1���ܿ}D?����jף1�qb��E��_jJ�3�4�>�T2�C���;/��>��Qr���/c��&�Y��Ao�����[OC������Uzx��]�
T{�`���V�=v��J�D�����1_�A�YBiBQ��V��~�7��J�`9���Qs�`������}�q�����[�hQ�졨t/�("�nA���R�J]��B5�J���z���������gb`������3F��[B���U �6��/*�Pۖ�N4B<ׄ���R:�Z��C�%;T�%��� l�)-t�ڧ��Ӧ-��e��X��s^�l����]��]���e��S%�٧�=W�o���vA#��;`�2��@�<a���Dآ���>Y�/R��m�b�|R��V����
�U1c�K�<�<tM��RF&Zp>zT�dk�N������� ���C2���7Ӝ  	�_a��"��c�F���Q]����e��3yY��>�S}�M�r3ܭ�`ˮ�R{�\{QD�,q���9v[�G���Z C���"���~����b�v�KQ�Ǒ݆r8�T��?p�|�zty)��|�KE	�Q���:��,Q�c���>V=�?��pR���{<w��E�3���A��:��k	����,�}�e�f��E���E���'�~�x^/w��9�Oh��^Z�9�N�HF���������G�VI��GL�C�����#��hۇK�A�a8\0A�Ĭ�؛���'ӹZҹ��=��gg��!����N����k��]�	���� �^m��}��q��siD� ����k��6K�~�r����M�"�*�2�*�":r��7n�s~1�Vie�70�͏
�U�O\��p�ᢓ��xѫ8�ȍ���[�fr�RJ�7-�x������.+zk>*������#��!������j�Jy֚a?���ޱq1p�� G	�eEW19-h�ߣ��Q�� W=T�ʷ}�x�7�/
#��^ȶUZ�����+�Z��.��Uu���Y��<ǫ��?���f��vn1	�����kF`UH���mjQ������*���
=�q6�g��¡�C�%����ӆ��;�&�=�"m1�p�VJF[�\{c��6Gu���z;!fN�\�r���9���	�[�^��#&1���e���>�O@�}�������S>4�:�>��F�SOf������?���K��	��<���N˶�($L��7��#S3?ҳ!��g��a����?�2��WF�x����n�̏�f%l�|�$�_��e�B�VjV�|��&�'BpO�w���Zr�ZBWi�ń� �1Q�>���i.����奮��>�4#x�WC7�0��ͨeˮ)A���t�Tػ"�nF��x���L���ٶt9�� ����i�]������`9�W��w�\a��q}�MU-��}2F�� ��sN^�΁4��J��l�P̳q�0������1޴��\Y�W���̵�m�r�G����V���V���r���M�3����I����V&�1���O��?�qW�o+���Y�_�_����F�%I�T��+�*r,�'��6{�N̈���dN�4�!�� F�x���?%-��5�1�e/Lȵ�O�3�ǜ���BV��n�W��id�e����z�����JF̗L;S�Ó�E�쌕��l���tq��� =W�{ڴG��K�M!]R9��t邭��"���Rm0=������J��t�Bʟ _�5���G��	}<�J�䉎���*_�=�}O�M� .Ð��08�:G2����;}`�C	�6V2��ý����%X��^���,^Lp��[:�?d�^���/�F�#��44�"�6�H8����逯w�&`PϺ���k6���p2������8�r��	�w����.G���w<૪0��@�	��E��p1�a�Ē}�e�E]������'���r�g�
~^P���^��2��!���Պ�[V�nFA⁔�x�w��-{ßH��y�+�1��ii25IS?�Wԫ6hO^1����m(3:�WR/�9��Ҳ=5�a�5V��X�$�������?*|շ��j�]yڮn����U�^ͫ$q������+��
�n^�\���$7�he�0��l�qjR�>w��e�U�N�<тG�^��rL��j
:�+?�� ���k˾��ǧ�6~^-7Mk�e?jG��0�����F�����	*��\�C�Z/R�D�~��B�"w���&�b����2�"<��*|W^�d����#�SefL���\�ͨM<(�;^0�f�5 �m��5}�ہI�U�p�hh4z΁�=��w��8QFq�~�O�1<�$i����!��<b�U��nEi�u��3;\Y;oi�w6�}+�K3��#�צ��7�������6�v-g���R���?.��@� ա�(S�D��4M�@OGΐW©�e�Y��猻��p�|��m ���uF{���,h0�0��z����v��>�vN^�;�&ټ�>��Q�U��>e�w<)*q1�~Zq�H֡�ws��~�>��9N�C*Cl����)��*���r^�x�XTȾl[��OVz��|�^E�Ϥ��b�O���iۉ�x��7˒sq&��!	��!�T����!���[Rɦ�f!ϗ9�	﫰�K���U�(���֪AZ=;�=��i�~����a�nB-��i�v�m���9Z���q	y�Ȼ=eq�o������o$|�s:�B0���]�e+>&�2CN	F��cOx��o�4TZ}ƴ�\7O�Ǒw���~�o3/�6��X(*JPcj@K����/�s~��\s��%���2�wk��,/*������8�I�9.�8[����w�4�'��8M��-��hx^L�$;3��4h��/��gE���U�x9>{R)�.��`��}�q7N�rG��$".��ҁ�>�w�A��R�ǜ�'q"�ǌ��]a��$�|�>ܧ1^/j��R[�t�y����_�^E�{x�p�P��3j�)ր��ӕ�
�s,P�k�o/9]3J�]/z�gT$�o�e����e���v~�����"أ��<�	p9uaF3ă�ㅘ7Ŝ�5+���7�����m�Nݽ���EA��F�,/�����@l���m������1�\���[�t�3)h]�6�*o|�l��8)G��J���^[���+�ğ7����6�����J�J�֜ �=�!Q�ojC�/��Br|Bo�9�tZ���%���a�7�\ڗ��U싪׳8/�U��+�H�$�Jc�0��{�����e��tJ[�^С���W�|��p�x�R蕿�:8�����]��h��U�Z�r���]����36���꒑h>��,V�J<�^�
]�Ķ�	|4z�آ;G��Y-�c���2WW���汹� i����o�0��|�>pq�b��]��n������\N�]��[#Ƥ���?�����y���+-я5�y\lDN���_y/�R@9�C�b�WUC].b�<�j��P�Ђ{��_%�������}��p&�J��\��o8>�l%Hsr�~�:��s%ru��Ki]���{v�W��󐁖�Q��,��ӿY	��$���ބ�5���E�	���}�A��A�U�8���0o3��X�\c�|�m��v9�D)�O��X�h^{�����,��k��]�	x��я"���ú{C{��PI.�/t�U���49\���k�@���d�4��CQdV�QBajNls̓"���Z<�:�x�,<���
���DaQ(����j_� �
  ��1b�˼�j�*d�熨!C����+jw	G�7��[-f*u�&p���3	VN�U���s��Z�k�ï�-�M1A�K�m�~�;G;:�]ɞ��;^Y�P\�%Q�0$����|)<�.ͥ�X�ŅK��K"��y��s�c�'񆩖���H^�����xw��tXW��f�n�,��-�yt���F�d��X4^�lV��	�\���B�}����Bv	�o�$�D)�o�.g�/���6f||�`�x�IU��s��NWї�.ݥ���ғ���[��kH2�A�^�B}��w��ۣ0�0���C���8�ت��+��t'����5����!;�䄂s
�� �K}	��1@�)7���ӣM��ƚ7��b�<epͫ�;p9roEQ1�4'��]�i�gW�A�B�U	���-i^���_�:\�J���zcۼx���3�}N��DM�%�d�K'jl��؛�;%ð+�����(�ud7�a��
��꒸��_Unq%)����U8.f��ꑸ�3�N�i�<1��ډc+&�9����=ٟ-/��v�$�z���J5?�2(Ĕ$�B]��P!���ҕ�����z�h-��yS<��-�;���Q��Pˡ�@�����u�A��͢�ذ���$m��,��,G S�7�-��	��DJ⻢��h��m�F2���L����J��"t2+�i�|����}�D�
��AG�"�)о��6���W�p�k_������%��]��V4F��z+�S9�p�v\���RB��?�l���mJ!�2��f�W/�������c�/W����m
�3Қ�c��ވaM�w*��X�����c���2��n����Fw�UWGˊ@�C���p�m9t���hQB��0���E���0���rӾ�#�3��v��B�]y?��m�c�4��AG1/���+)�3������r�mdQ�಻b�ru�Wh�d��b��,�n6G4�J0m�yɗ������)&�)���BJ�?�"7Q�ߜ_c��>���T���-���Aջffv��Y���8e;z#
S��ZAV!~�����F���2�I��v� ���rL�d�/�6ؠ�	َ�`�;:+�ds<��}k�V,��)��t�kz���xo�@p�-z��V�6Z����^ơ.��v� 
��d���	����w_�]�#��I�1e��.�^Y��������p�f?Oi�O�WHR��K��ç��\�7%I�rS�����HiN��՟-G�A/��Q�C gݰ�K��w}�/YӤ�d�֯�[U�1֥߯o�(C rF$�>����ӯ	���-Z������T?Ȯ�bdU4d���~o5����k�0B��9��O�\zM�!R��rd��&�����r�|���<(-�E�_��a#����7a��$����2
y�h�k�7+��@�)�6V�E�[�$1�n�T^�3��UD1(�x����iɳm��E��_��[g�-<������5��41�A-���������$V��k�C��He#]��H��2�m���{s��i���ҽ�ş]>��{��.�ڀ�RT�7�߽5���'�#�W@NV*o�6���1Ed<b�-�����U���.	��{6��u-^�h��2���o* �R��T�V)I��{�!d����_1�)��<���+5����D��7�g"_��6�*�E�>��+�!�(���F�8���vA�g�"�_Q��})5��`�1�pK�r�F��(��3�2ՠs�U q� �َdZ0fg����ꎠlO�+�����B/���3��'���Lt�
7|\�_?3��,�W��C��ؠD�@�Q���A���4v�c�w)\�/��6�Ű��.n$���,oS=���D;�h�\��q�0='�/q1��%�4�@���V��T���)�5����+^ݏ���0��ۤ�0{�88��/�*���3wZ�Q1�~��������H� QV��k�/�d�9�m`fd��jL�εTj{�`�}�<�J��-�~|�H�8�@{8Wng51o����d8z����Rr{}��C�>)��^�+ƈ���D�TT�w��YL�Ȩ����� �H��k�4�+�6)[öOsf�5�����wyɡ;�a� �C� Q��_[~g�U�a����jB�VO�9iW�7����]�Md�iq����w��3��e�������ltE@��󅝕��W�>M�e�b��cVW�1ڰV7wn�(r�B�[=��)Zh@*I���U���4���[2<����S+��+�G��1
��_���!�z�Z�Ȕ����� wܱ�^t)���s�F$��%��Z��t���V���͠}B��\ ����
���"~�@���m@^�Z�;^�h����D���ў�-g�9�(�S#�1a�+���d����c�y�j��Nl�t.?��[��	Ȕt��G��Zv#պHŗc#�����'�A�L� �у
��b�mV��Bğ�!�=4a4�`|Ca�E��T����W���Po��E@~�[���!��a�x�$B�qy��	fs
ja�t	��H>��>��he����+����I1��A��� M����1����D�5��u-�շ����m,kU��OE��?߬�ߟ������f�z            x���ٍf����ϵb��}�-2C�c������t�C2�ȍU��ճg�c��~���_+��������������G��*�(�6�џ�8������k�F }�=c�9����Wߨc��K���[�I����O���F�穯�el}��na~��UW�����:��;_�5���3���q��E���{Gi}q���W�iu����$WGzumڍ�#\Ʌ�h�6��^���ա�i-:�]��|P���"�]k��-�[����ٖ�m}3�B�m�R$v����rW�E{��~+^@u���;�"�<������F�W
t��_|�����.���z��U���hh����[n?��*�Tr�>O�MK���z˹��ꄈoO�=ҡ��t��^F�fwE��e��U�b��l�zl���g����@�����*eK+� *���VnEڊ%9��6��dY�X���+B?���2��P�[H�TtT����.ym��+�P7�<�ظ����_�C���m�b� �i�2V�����n����p�7�(���k^�G+�qP�
���!�XRm��0�R@}�YKK�Q��KF�6եm��5:�m����W���@HH�>B���l�5�B�&d�k�{��2%�eJn��g�U8�ӥK;o� �#7�}T3�p!j�����ʫ%�,s_�,)x�	}�>��-�,խ�e�.���^<~M�[Nr�}˳r�;�LmHI����~�M1��;K!�l��7b��7f��S���&��g#~78��n_yf����>F�+��g�F
��m2��q��h��vr���*� ����ILQJore�߱����Z��E�B���=U�����}sWS��]Ļ�O�p�2��c�,�xK+�Ɏ_bnBff�
e�/2��e�&�C�5�?�ʩ�qވ����K�ג�"�9B�Y�Vhd�0���h�����ei�A\��T�,��/�+.W��1-¦P�T0�C�/g�h]+�.M�r-^�0��U��Dl�1^Q��3!���'���ϱ�r���	3���}HYu\�k�
�O:��+�o����;��>fʀ��u�1���Eɫ����A�Udr��,�Ga.e���E'6A*]!DBf薄��I�%�q� �%��dl$�q�A�Fa���!g�����_ݽ(�F+]3�F�N��([D^$��X����uH���v����fd�w��@|5�,Ww'���C�r���2�"2 �=[A�̧؅����F�/J @)����\Bb狸c��� A����#�5�Qq�0�?�5��v�-0�� �Z�^�_�@D�ː�;1�IK<�u��}E$懑���;���M�Є
o5�(c'���PL��db���q~+�p?L���Q��g`|vV��CQj�q�rDua�����a�E�ԒLnO�"9�(����3��-��I�Q�(F�A`�"��ٕ�sيI��:�i`� i2c��=��PX��������&Z�/��Y�)2M��#���tqA9g���o��$��q0x��lg�3J�蟥�PA �?r�ƈ��@뤛�L(h�t˪��Hg��f�&���e=�Y� ����iB�#�W�5��I�2���V��)5
R��O�n��A2q�!p�Kɚ00�e�wdX�s�e�3����0�4�P�g��8��V7&J�ce=!��Q���(�Z���
�9��V��-�
5s*�CEѦ�~FɪSE�v��&�ÛŰe�2�eV;u_B�����%.E{ɭa��Cuhr��eع0�\;�Ca:�.[a$�j�9�pa�S*��Pa�% ��Y5�[�p"��uv���~���׎��A�}q/$���*��w�SR��˄ƈNUbuEg�������{y��J�����/��XE7��@W�A��(� b'c�@���\Z!c�<zI|NCFL�w��$ǈ� ���ZH����'�퐦�5�����=D���b����.B�N'1f�*���
*���e���z_�,����藜lD�f=Ҍد��+�4e*���H�$�B@Q��$b��֩�$����-�T�i\�R ��*+�u�eD���ܰ��4N�3x��.�?��g2ƕ�����3� m"Y���m���X"�Fo۾F������S�a�"�*}�F)�?���z�L�ہ�V*��q���
-P�T�R2����7ǵ�Q�-��8O�M=L�<��O���43!�[�q5&f�L�$'K���d>�!�s�S#�?��Yj*f����j�Η�M]<aJnn#��2:J$T��{|��mq���G�����ʦ�[���':�MYO��2�&�F~��=�3�:tݝRnuA"�t�.m����"]3@���s٭�YA{�M��?#�P ��$:N�ſm�ٝ��wە��|���F�Y#�EdkN'��'�k}����!Dg�"�k�o���ǰ���E�,�1�(�a�v�ӕQ��%^� �����Gd��X�~B�K�3��%*
�vWfo�M��m�3�H�yHm!���7�P)�ֻ�9�.�R�(���2�(�Bõ(���Z둳�q;{O�j*�����А~~Gŷ�x�y������o?��B�z�cVa���\� �yݣ�Qi�!D���1l%c�ȑ�Jq~m%"�?��ۜ��*5cx����z�.��y�B�E�N�x'r��C��(� r�%���p�'��x�)�]��p��;w�!�9#!���#"]�D�����i ��W���gH�	�*�e�*D�v���:�ͭ	J����ԓcm��Fk�0�sp�_lcL�ֈr@(��5q�z4�ĞZ�G+*5�=�"B]>���œ�ku;�x`�1D���U��l��ǃ��Uyd�5�W���� �;���5�k?���2R���������Q8���ڋΨ����䴋Zb��gs?�cy�-_y���Gsg����c���+J��W;�BC���<�e3衳���R68�FiY.�A�$�����f6CH��.@�a# Eg�׳�'��sfY����^�y�u���$E��I�V9�o�%[(�Q�m��B�p�͐J�V-�U���� s/�ȵl��"dfeU:-���rh!�Z�����f�{���L����%���l��i��^4��F�I��Bõ���T*P��By��ĵpPbx���c�WӭЇ=�8#G�剺9tB�h��1��a��S��:�� ��.}@����S����L��E����M�^�A�`�/�Pϯf>��\��S6df2����"�;R�!���}�7iyM@�s�n���n`�:�AR���u��S��x"+ai�[�ПA�<��=ڟ�]�M,b
N���q{����{�8��?�z	�w����u�0U���Zݽ��4�Ds�ӧ�a�@�ԓ�'ٶ̗1�B��X3�H%�mZ�-#g C`�@j�>P������,4:xy�Z��`q��?���;}`N�G��3$3L�f���~�{���3�N������	��n>o�����2�����tW[��s�0`z��uڣ8��)���V��U>�����o8��0m.�=�#�?̹L�4��(j���ֶ�m���m\�����-`����j�ɐzS�3Ƚ����?�(����5���9��ܨ�lm���2熖.�Z�s$C"�Nk(��ɜ�u���ϕ;�j�����UM�� 2�D���lι�]d"��.������"�����ݙwE+È���Py�(D�b�v�P�("C���������1���{�Y�lj���Գ1�*U�,� �3�D���İݲ�p�~�
e�SS���gȠ�Bb}co{�Q3�$ݺ�if>�}�R�������ч5��N�dΌ���e�M��2^�M�E�[��1�$�y�F�Mcxf7<4����e�n.�GQ��v�eϜ�(�B�3<�X3R��&w�&z��K*�{~�Ƨa2�F�S��nT�,���f��Q��f�̂�Ѐ���Im{�} �  ���8�5�r�A�&�Y]:�����LJ}�D���z�ɋ)���e0�1��L�r����x�e���S⼿�H��[�&C��TfP� 5��/�'�@&X��HV�c��ީV��^�H�s��y����A�P�%�v�k%��@W�yl�_'�jT���(���i�0⛫2]~�$�iC��jn$罅�:�h[��0�@ba`B�2&N�6��`p�{�#cԖ�������,g�$���iN�0�(.:@G�����j��7���{	�����	��b��zQ�l	OUh�.��2��<���vHv���
F���L$�\۔R{��[���b�']d6C�Ȭ�F�Q��� �{���]5|��a�K���ʥN�z���w�rY�Z�شU]t[�2ɴ��3Z��h�����n��i�諾�~��q�i�I#A����3�U�5����+�Ա��qT�|Hc��z=�����'	3<m�eJ��H�b6>�6��Ԗ)y�+�W�����?�Uن�wa'�!ݒsW��V�LY�u�>�P�Ad�=>(F>S����h/�E����/�	[�;Sb� �ǭ~�,sfPN��E��yH��MVCQ�Y~��e�Ƚ�HG�)�f �?'/x�m��	�>Rn7h�ul�y]m���w ����^?�J��1M�z�����&�9��#	��3��8����� �)x`�$e�A]�	 C��ӎ�I`x��B�uf�� �ɝݳ�5÷��g�]M�V�@�\ -+=j��a�Q�Avǳ�	Ȥ)U7��#�L>�`�aRX��	�9�	�.��	��-�\]�k�M�J��5ϩn2I�#/g����O���e4 i�=3�v�)H2y(��WFo.?A"�z�(����zFqq�� /q���U])d�Gp1�K:������;M o,ʗ�Ϋ4�% �ڹ��;����U�G"'!M��+B�	���6Q�����e���&W���}��J�nʌ�h�0�ʢM�].|'�u,�䡾�I>5\F�\�T�yP[ZSo�J23%�kZ�E��L��`Ė���A��"p�pd���\
��PT�2J�Xų��Y����4��<.��c��9(������[�����۹�H�߻�-���z׵�!�T�h���]QьkS��`n}�zR��[SbS~��F��FtYg�B��z؋l��]S���b���_`�mn�p3�Y�Y���J��ᆎ�M�QC�~/��2�rG8D� C<������[����d�f��1���%��G�Æ��ؼ}��!O�I�y��z�5D@6��}�@��jeW_I8]���9�_�Hb~�\*LO��pd ���^\�iQwUw�[��LY�뾒�n-E�������8X��2^o|FP�}�����$ 4��Z��á5��{��Q|��Ks�����LC‏;eO�ǁ`"z�����9
��GC?�3q+`�r�\m� G��:4-e�y�����m��̷�`�I!~�@�ؐe~��q�\�<�a��k��"g�@H��.⁜�P����\2n��a%�E�ˋ��$����ߨ�®"�����'Vin��Ճ%n�2�r��-u.�	�%�O�K�ͫDޱ�[ބ|F�ޣlZe6'����F_�xv���h�%s�;�I-�3ˏ�~Y�l�!y��w	ir#hN ڐ�/eL�'L��ɴ��jS�a@�F��>���^������=y�&�\�c6e��D7Q�/�J�f���d��`���o�-��}��A�^�L�}~,����}��岝,	gA�;��Θ��ӌO���g9�߳ ��#5�s�B,1�[߳��v��R�~����a�D��P\�b��E�{yD$�,Q;����1�hx����}�{=�8"�H�4�7S�������q�~I�@��.��ݓ5n��2�mbeI��=y�Z�� ���#��|���6<t9~&P���w�b��G�i>M|�3�r��^��@x�R<i����8߮�X��D)@�m�Ѿ�@�,,x{jK<�Ҿ���A���{�7�!\�)��'�[�ԭ1�
v��/�Q��?�d,��k�p�-�/Icn	�Tş��������I��y�h�|G`��0���5`�b�cs��/ɼ��JS_��l���9�P�R{y�"svIr/�u�Fu?c��Y(I���n�"}���hQ��������z�      	   K   x�3�t�/�/K�I����2�t�K)J-.N�4�2�tK-����II�4�2�t�r�3�S��ԢL�6c�=... 9��         ]   x�3�t9�2)�$�������P��\��B��������D�����Đˈӹ�����9C���R���K�Lįڄ�5� hnqIf.�c���� *�     