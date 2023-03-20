alter table ssh_configs
alter column values type jsonb using values::jsonb;

alter table ssh_configs
add column identity_files jsonb;

-- Take all ssh_configs pre-existing identity_file column and convert to array
update ssh_configs
set identity_files = json_build_array(identity_file)
where identity_file is not null;

-- Drop the old identity_file column
alter table ssh_configs
drop column identity_file;

-- now we need to migrate the json from the 'values' JSON to be in the format of: {"key": ["value1"]} from {"key": "value1"}
UPDATE ssh_configs
SET values = (
    SELECT jsonb_object_agg(key, jsonb_build_array(value))
    FROM jsonb_each(ssh_configs.values)
);