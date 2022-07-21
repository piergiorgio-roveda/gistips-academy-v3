# tb_lyr

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Create

```sql
CREATE TABLE tb_lyr
(
    item_token character varying,
    post_date timestamp without time zone DEFAULT now(),
    post_modified timestamp without time zone DEFAULT now(),
    post_status character varying DEFAULT 'publish',
    g_slug character varying,
    g_label character varying
);
--
ALTER TABLE tb_lyr
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE tb_lyr
    ADD PRIMARY KEY (pid);
--
UPDATE tb_lyr
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE tb_lyr
    ADD CONSTRAINT tb_lyr_unique3 UNIQUE (item_token);
--
-- Trigger
--
--DROP TRIGGER twd_update1_tb_lyr ON public.tb_lyr;
--DROP FUNCTION public.fwd_update1_tb_lyr();
CREATE OR REPLACE FUNCTION public.fwd_update1_tb_lyr()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE tb_lyr
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_tb_lyr
    AFTER INSERT
    ON public.tb_lyr
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_tb_lyr();
-- F2
CREATE TRIGGER twd_update3_tb_lyr
    BEFORE UPDATE
    ON public.tb_lyr
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
--
COMMENT ON TABLE tb_lyr
    IS 'live:220718';
```

```sql
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','pid','serial',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','post_date','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','post_modified','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','post_status','character varying',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','g_slug','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','g_label','character varying',true,true);
--
```

```sql
--ALTER TABLE tb_lyr ADD COLUMN label character varying DEFAULT 'Castles';
ALTER TABLE tb_lyr ADD COLUMN title character varying DEFAULT '';
ALTER TABLE tb_lyr ADD COLUMN title_dlg character varying DEFAULT '';
ALTER TABLE tb_lyr ADD COLUMN feat_type character varying DEFAULT 'point';
ALTER TABLE tb_lyr ADD COLUMN inToc smallint DEFAULT 1;
ALTER TABLE tb_lyr ADD COLUMN lyr_type character varying DEFAULT 'db';
ALTER TABLE tb_lyr ADD COLUMN lyr_update character varying DEFAULT 'on_move';
ALTER TABLE tb_lyr ADD COLUMN feature_zoom integer DEFAULT 12;
ALTER TABLE tb_lyr ADD COLUMN feature_zoom_max integer DEFAULT 1;
ALTER TABLE tb_lyr ADD COLUMN maxZoom integer DEFAULT 22;
ALTER TABLE tb_lyr ADD COLUMN label_zoom integer DEFAULT 15;
ALTER TABLE tb_lyr ADD COLUMN zIndex integer DEFAULT 500;
ALTER TABLE tb_lyr ADD COLUMN icon character varying DEFAULT 'emoji_circle_carto-1f1ef-1f1f5_mod-blue.png';
ALTER TABLE tb_lyr ADD COLUMN maincolor character varying DEFAULT '#00AAFF';
ALTER TABLE tb_lyr ADD COLUMN maincolor_hide character varying DEFAULT '#a3becc';
ALTER TABLE tb_lyr ADD COLUMN slug character varying DEFAULT 'pt_castle';
ALTER TABLE tb_lyr ADD COLUMN g_style json;
ALTER TABLE tb_lyr ADD COLUMN g_tables json;
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','title','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','title_dlg','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','feat_type','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','inToc','smallint',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','lyr_type','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','lyr_update','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','feature_zoom','integer',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','feature_zoom_max','integer',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','maxZoom','integer',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','label_zoom','integer',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','zIndex','integer',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','icon','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','maincolor','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','maincolor_hide','character varyin',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','slug','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','g_style','json',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','g_tables','json',true,true);
```

```sql
ALTER TABLE tb_lyr ADD COLUMN geoserver_name character varying DEFAULT '';
ALTER TABLE tb_lyr ADD COLUMN geoserver_style character varying ;
ALTER TABLE tb_lyr ADD COLUMN tile_url character varying ;
ALTER TABLE tb_lyr ADD COLUMN pointerEvents smallint DEFAULT 0;
ALTER TABLE tb_lyr ADD COLUMN tile_layers character varying ;
ALTER TABLE tb_lyr ADD COLUMN tms smallint DEFAULT 0;
ALTER TABLE tb_lyr ADD COLUMN author character varying ;
ALTER TABLE tb_lyr ADD COLUMN lyr_slug character varying ;
ALTER TABLE tb_lyr ADD COLUMN icon_type character varying ;
ALTER TABLE tb_lyr ADD COLUMN icon_xpos character varying ;
ALTER TABLE tb_lyr ADD COLUMN icon_ypos character varying ;
ALTER TABLE tb_lyr ADD COLUMN icon_sliced character varying ;
ALTER TABLE tb_lyr ADD COLUMN geojson_url character varying ;
ALTER TABLE tb_lyr ADD COLUMN g_options json ;
ALTER TABLE tb_lyr ADD COLUMN icon2 character varying ;
ALTER TABLE tb_lyr ADD COLUMN icon3 character varying ;
ALTER TABLE tb_lyr ADD COLUMN icon_dim character varying ;
ALTER TABLE tb_lyr ADD COLUMN icon_dimanchor1 character varying ;
ALTER TABLE tb_lyr ADD COLUMN icon_dimanchor2 character varying ;
ALTER TABLE tb_lyr ADD COLUMN label_single character varying ;
ALTER TABLE tb_lyr ADD COLUMN legendicon character varying ;
ALTER TABLE tb_lyr ADD COLUMN style_group json ;
ALTER TABLE tb_lyr ADD COLUMN base_color character varying ;
ALTER TABLE tb_lyr ADD COLUMN fillopacity character varying ;
ALTER TABLE tb_lyr ADD COLUMN labels json ;
ALTER TABLE tb_lyr ADD COLUMN bordercolor character varying ;
ALTER TABLE tb_lyr ADD COLUMN note character varying ;
ALTER TABLE tb_lyr ADD COLUMN disable_mapclick smallint DEFAULT 0;
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','geoserver_name','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','geoserver_style','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','tile_url','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','pointerEvents','smallint',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','tile_layers','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','tms','smallint',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','author','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','lyr_slug','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','icon_type','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','icon_xpos','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','icon_ypos','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','icon_sliced','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','geojson_url','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','g_options','json',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','icon2','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','icon3','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','icon_dim','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','icon_dimanchor1','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','icon_dimanchor2','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','label_single','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','legendicon','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','style_group','json',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','base_color','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','fillopacity','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','labels','json',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','bordercolor','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','note','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_LYR','disable_mapclick','smallint',true,true);
--
ALTER TABLE tb_lyr
    ADD CONSTRAINT tb_lyr_unique4 UNIQUE (g_slug);

```
