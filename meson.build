project('io.github.lainsce.Emulsion', ['vala', 'c'], version: '2.0.1')
gnome = import('gnome')
i18n = import('i18n')

add_project_arguments([
		'--target-glib=2.40',
	],
	language: 'vala',
)

if get_option('profile') == 'development'
  name_prefix = '(Development) '
  profile = 'Devel'
else
  name_prefix = ''
  profile = ''
endif

app_id = '@0@@1@'.format(meson.project_name(), profile)

conf = configuration_data()
conf.set_quoted('APP_ID', app_id)
conf.set_quoted('G_LOG_DOMAIN', '@0@@1@'.format(meson.project_name(), profile))
conf.set_quoted('NAME_PREFIX', name_prefix)
conf.set_quoted('PACKAGE_NAME', meson.project_name())
conf.set_quoted('PACKAGE_VERSION', meson.project_version())
conf.set_quoted('PROFILE', profile)
conf.set_quoted('VERSION', meson.project_version())
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
conf.set_quoted('DATADIR', join_paths(get_option('prefix'), get_option('datadir')))
conf.set_quoted('GNOMELOCALEDIR', join_paths(get_option('prefix'), get_option('localedir')))
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')


add_project_arguments(
    '-include', 'config.h',
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language: 'c'
)

asresources = gnome.compile_resources(
    'as-resources', 'data/io.github.lainsce.Emulsion.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

sources = files(
   'src/main.vala',
   'src/manager.vala',
   'src/window.vala',
   'src/pid.vala',
   'src/utils.vala',
   'src/palette.vala',
   'src/color.vala',
   'src/coloreditpopover.vala',
   'src/portal.vala',
)

dependencies = [
    dependency('gio-2.0'),
    dependency('gtk4'),
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('gee-0.8'),
    dependency('libadwaita-1'),
    dependency('gmodule-2.0'),
    dependency('json-glib-1.0'),
    meson.get_compiler('c').find_library('m', required: true)
]

executable(
    meson.project_name(),
    sources,
    asresources,
    dependencies: dependencies,
    vala_args: [meson.source_root() + '/src/config.vapi'],
    install : true
)

subdir('data')
subdir('po')

meson.add_install_script('build-aux/post_install.py', join_paths(get_option('prefix'), get_option('datadir')))
