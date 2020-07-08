/*
 * schema.sql
 */

create table snp {
  uid           text primary key, -- (example 1:79033:A:G : chr:position:ref:alt)
  chr           text,
  position      int,
  id            text null, -- (rs2462495 or chr:position if no rsId)
  aaf           float, --  (range 0-1)
  maf           float, --  (range 0-0.5)
  sample_number text
};


create table genotype {
  snp_uid       text, -- (example 1:79033:A:G : chr:position:ref:alt)
  genotype      text
};


create table cpg {
  uid           text primary key, -- CpG_uid: chr:CpG-C-site (same as CpG-Start-site) : example 1:15769
  chr           text,
  position      int,
  meth_mean     float, -- (of methylation)
  meth_var      float, -- (variance )
  sample_number text,
  -- from_target: (I will add this information )
};

create table methylation {
-- CpG_uid
-- methylation values.
};
