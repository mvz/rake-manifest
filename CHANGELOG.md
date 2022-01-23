# Changelog

## 0.2.2 / 2022-01-23

* Drop support for Ruby 2.4
* Support Ruby 3.1

## 0.2.1 / 2021-05-15

* Emit success message when manifest check is succesful

## 0.2.0 / 2021-01-08

* Keep directories out of the manifest and only include files. This as a
  breaking change that will require the manifest file to be updated or
  regenerated.

## 0.1.1 / 2020-08-23

* Improve handling of literal file names in the patterns list:
  - Do not include these file names in the manifest file if the files do not exist
  - Do not assume these files to exist when checking the manifest file
* Use configured manifest file name in both check and generate tasks

## 0.1.0 / 2020-08-07

* Initial release
