enum Env {
  prod,
  dev,
}

const envString = String.fromEnvironment('env', defaultValue: 'dev');
final env = Env.values.byName(envString);
