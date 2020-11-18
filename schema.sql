/*
 * schema.sql
 */

--
-- UID: varchar(50)
--     chrom:position:ref:alt
-- ex:
--     1:79033:A:G 
--
-- Note:
--  - Check if it's possible to make the UID smaller OR a number?
--  - Possible values for chrom?
--  - Possible range for position?
--  - Possible range for sample_number?
--

create table snp {
  uid           varchar(50) primary key,
  chr           varchar(10),
  position      int, -- 2^32
  ref           char(1),
  alt           char(1),
  sample_number int, -- XXX: update according to possible range
  aaf           float, --  (range 0-1)
  maf           float  --  (range 0-0.5)
};


create table genotype {
  id            serial primary key,
  snp_uid       varchar(50),
  genotype      text
};


-- CpG's UID:
--    chr:CpG-C-site (same as CpG-Start-site) : example 1:15769
create table cpg {
  uid           varchar(45) primary key,
  chr           varchar(10),
  position      int,
  meth_mean     float, -- (of methylation)
  meth_var      float, -- (variance )
  sample_number int
};

create table methylation {
  id        bigserial primary key,
  cpg_uid   varchar(45),
  meth_val  text,
-- CpG_uid
-- methylation values.
};

create table leadsnp_chr {
  cpg_uid       varchar(45),
  chr           varchar(10),
  start         int,
  end           int,
  sample_number int,
  mean          float,
  variance      float,
  snp_uid       varchar(50),
  snp_position  int,
  beta          float,
  t_stat        float,
  p_value       float,
  test_number   int
};
