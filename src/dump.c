/* dump.c  acb  (9|10)-9-1994
 * code for dumping rules, etc.
 */

#include <stdlib.h>
#include "rtn.h"
#include "map.h"
#include "transform.h"

static int dump_atoms(pNode atoms);

static int dump_node(pNode node)
{
  switch(node->type) {
  case literal: printf("\"%s\"", node->data); break;
  case symbol: 
    printf("{%s", node->data); 
    if(node->params) { printf("("); dump_atoms(node->params); printf(")"); };
    printf("}"); 
    break;
  case mapping: dump_node(node->params); printf(" > %s", node->data); break;
  case deref: printf("DEREF("); dump_node(node->params); printf(")"); break;
  case var_conddef: printf("%s << ", node->data); dump_node(node->params); 
      break;
  case var_def: printf("%s = ", node->data); dump_node(node->params); break;
  case code: printf("code:"); dump_code(node->data); break;
    break;
  };
};

static int node_iterator(pNode node, int param)
{
  dump_node(node); printf(", ");
};

static int dump_atoms(pNode atoms)
{
  node_map(atoms, (NodeIterator)&node_iterator, NULL);
};

static int option_iter(pOption opt, int param)
{
  printf("\t\t"); dump_atoms(opt->atoms); printf("\n");
};

static void dump_options(pOption opt)
{
  option_map(opt, (OptionIterator)&option_iter, NULL);
};

void dump_params(pParam params)
{
  if(params) {
    printf("%s ", params->data);
    dump_params(params->next);
  };
};

static int rule_iter(pRule r, int param)
{
  printf("%s", r->symbol); 
  if(r->params) {
    printf(" ( ");
    dump_params(r->params);
    printf(")");
  };
  printf(" : (%d options)\n", option_length(r->options));
  dump_options(r->options);
};

void dump_rules(pRule r)
{
  rule_inorder_traverse(r, (RuleIterator)&rule_iter, NULL);
};

/*
 *  code for dumping mappings
 */

static void dump_mapopt(pMapOpt opt)
{
  printf("    \"%s\" ", opt->key);
  switch(opt->action->mode) {
  case replace:
    printf("-> \"%s\"\n", opt->action->out);
    break;
  case subst:
    printf(">> \"%s\"/\"%s\"\n", opt->action->key, opt->action->out);
    break;
  default:
    printf("?\n");
  };
};

static void dump_mapping(pMapping m)
{
  pMapOpt o = m->options;
  printf("%s : \n", m->name);
  while(o) {
    dump_mapopt(o); o=o->next;
  };
};

void dump_mappings(pMapping m)
{
  while(m) {
    dump_mapping(m); m=m->next;
  };
};

/*
 *    code for dumping transformations
 */

static int print_param_iter(char *param, void *foo)
{
  printf("/%s", param);
};

static void dump_transcmd(pTransCmd cmd)
{
  if(cmd->addr) {
  };
  printf("%s", cmd->cmdname);
  if(cmd->params) 
      list_mapcar(cmd->params, (ListIterator)print_param_iter, NULL);
};

static int dump_transopt_iter(pTransOpt opt, void *beable)
{
  printf(" \"%s\" -> ", opt->key); dump_transcmd(opt->cmds); putchar('\n');
};

static int dump_xform_iter(pTransformation xform, void *blah)
{
  printf("transformation: \"%s\"\n", xform->name);
  list_mapcar(xform->options, (ListIterator)dump_transopt_iter, NULL);
};

void dump_transformations(pListNode list)
{
  list_mapcar(list, (ListIterator)dump_xform_iter, NULL);
};
